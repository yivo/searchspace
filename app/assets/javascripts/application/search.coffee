$ -> new Search()

class Search
  constructor: ->
    @$phrase      = $('#search-phrase')
    @$outlet      = $('#search-outlet')
    @performLater = _.debounce(_.bind(@perform, this), 200)

    @bindInputEvents()
    @bindHistoryEvents()

    @focusPhrase()

    # Handles preset phrase.
    @perform(history: 'replace') if @isSuitablePhrase(@getPhrase())

  bindInputEvents: ->
    @$phrase.data('previous-value', @getPhrase())

    # Handles user input.
    @$phrase.on 'input', =>
      currentValue  = @getPhrase()
      previousValue = @$phrase.data('previous-value')

      if currentValue isnt previousValue
        @$phrase.data('previous-value', currentValue)

        # User input seems to be suitable phrase.
        if @isSuitablePhrase(currentValue)
          @performLater()

        # If user cleared search phrase or started to input something too short.
        else
          @$outlet.empty()
      null

    # Handles enter key.
    @$phrase.on 'keypress', (e) =>
      if e.keyCode is 13
        @performLater.cancel()
        @perform()
      null

  bindHistoryEvents: ->
    $(window).on 'popstate', =>
      _.tap $.trim($.deparam(location.search.replace(/^\?/, '')).phrase), (phrase) =>
        @$phrase.val(phrase)
        @jqXHR?.abort()

        if @isSuitablePhrase(phrase)
          @perform(history: 'replace')
        else
          @$outlet.empty()

        @focusPhrase()
      null

  focusPhrase: ->
    @$phrase[0].selectionStart = @$phrase[0].selectionEnd = @$phrase.val().length
    @$phrase.focus()

  getPhrase: ->
    $.trim( @$phrase.val() )

  isSuitablePhrase: (phrase) ->
    $.trim(phrase).length > 2

  perform: (options) ->
    pageBaseURL = "#{location.origin}#{location.pathname}"
    pageFullURL = "#{pageBaseURL}?#{ $.param(phrase: @getPhrase()) }"

    # Manipulate history.
    if options?.history?.replace
      history.replaceState({}, '', pageFullURL)
    else
      history.pushState({}, '', pageFullURL)

    # Loading indicators.
    @$outlet.html(JST['search/loading-indicator']())

    # Perform request.
    @jqXHR?.abort()
    @jqXHR = jqXHR = $.getJSON('/api/search/' + encodeURIComponent(@getPhrase()))

    jqXHR.always => @jqXHR = null

    jqXHR.done => @$outlet.html JST['search/results'](jqXHR.responseJSON)

    jqXHR.fail =>
      if jqXHR.statusText isnt 'abort'
        if jqXHR.readyState is 0
          @$outlet.html JST['search/network-error']()
        else
          @$outlet.html JST['search/server-error']()
