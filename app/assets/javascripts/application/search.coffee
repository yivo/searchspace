$ -> new Search()

class Search
  constructor: ->
    @$phrase      = $('#search-phrase')
    @$outlet      = $('#search-outlet')
    @performLater = _.debounce(_.bind(@perform, this), 333)

    @bindInputEvents()
    @bindHistoryEvents()

    @focusPhrase()

    # Handles preset phrase.
    @check(history: 'replace')

  bindInputEvents: ->

    # Handles user input.
    @$phrase.on 'input', =>
      @check(search: 'later')

    # Handles enter key.
    @$phrase.on 'keypress', (e) =>
      @check(search: 'immediately') if e.keyCode is 13

    # Handles button click.
    $(document).on 'click', '.js-trigger-search', =>
      @check(search: 'immediately')

  bindHistoryEvents: ->
    $(window).on 'popstate', =>
      # Perform these action:
      #   1. Extract phrase from query string.
      #   2. Update phrase in DOM.
      #   3. Check and if required issue a search request.
      #   4. Focus phrase input.
      _.tap $.trim($.deparam(location.search.replace(/^\?/, '')).phrase), (phrase) =>
        @$phrase.val(phrase)
        @check(search: 'immediately', history: 'replace')
        @focusPhrase()
      null

  # Sets focus on input and moves caret to the end.
  focusPhrase: ->
    @$phrase[0].selectionStart = @$phrase[0].selectionEnd = @$phrase.val().length
    @$phrase.focus()

  # Returns current phrase. Performs normalization before return.
  getPhrase: ->
    @normalizePhrase(@$phrase.val())

  # Trims phrase and collapses whitespace in one space.
  normalizePhrase: (phrase) ->
    $.trim(phrase.replace(/\s+/, ' '))

  # Checks if phrase is ready to be used for search (minimum length is 2 characters).
  isSuitablePhrase: (phrase) ->
    @normalizePhrase(phrase).length >= 2

  # Checks state and issues new search request is needed.
  check: (options) ->
    currentValue  = @getPhrase()
    previousValue = @$phrase.data('previous-value')

    if currentValue isnt previousValue

      # Needed to compare values in future.
      @$phrase.data('previous-value', currentValue)

      # Kill any active requests.
      @jqXHR?.abort()

      # Clear any queued requests.
      @performLater.cancel()

      # User input seems to be suitable phrase.
      if @isSuitablePhrase(currentValue)
        if options?.search is 'immediately'
          @perform(options)
        else
          @performLater(options)

      # If user clears search phrase or starts to input something too short.
      else

        # Be responsive.
        @$outlet.empty()
    null

  # Actually issues a search request.
  perform: (options) ->
    pageBaseURL = "#{location.origin}#{location.pathname}"
    pageFullURL = "#{pageBaseURL}?#{ $.param(phrase: @getPhrase()) }"

    # Manipulate history.
    history["#{options?.history ? 'push'}State"]({}, '', pageFullURL)

    # Loading indicators.
    @$outlet.html(JST['search/loading-indicator']())

    # Perform request.
    @jqXHR = jqXHR = $.getJSON('/api/search/' + encodeURIComponent(@getPhrase()))

    jqXHR.always =>
      @jqXHR = null

    jqXHR.done =>
      @$outlet.html JST['search/results'](jqXHR.responseJSON)

    jqXHR.fail =>

      # Aborted request is OK.
      # This happends when user updates phrase and we issue new search request.
      # We just cancel the previous.
      if jqXHR.statusText isnt 'abort'
        if jqXHR.readyState is 0
          @$outlet.html JST['search/network-error']()
        else
          @$outlet.html JST['search/unknown-error']()
    null
