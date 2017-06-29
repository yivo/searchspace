toggleON = ($result, $toggle) ->
  onSuccess = (details) ->
    detailsHTML = JST['search/' + $result.data('source').replace(/_/g, '-') + '-result-details'](details)
    $result.append(detailsHTML)

    $toggle.text($toggle.data('on-text'))
    $toggle.data('status', 'on')

    # Cache loaded details.
    $result.data('details', details)

  onFailure = ->
    $toggle.text($toggle.data('error-text'))
    $toggle.data('status', 'error')

  if (details = $result.data('details'))?
    onSuccess(details)

  else
    $.getJSON('/api/details/gsmarena_handhelds/' + encodeURIComponent($result.data('url')))
      .done(onSuccess)
      .fail(onFailure)

    $toggle.data('status', 'loading')
    $toggle.text($toggle.data('loading-text'))

toggleOFF = ($result, $toggle) ->
  $result.find('.js-search-result-details').addClass('hide')
  $toggle.text( $toggle.data('off-text') )
  $toggle.data('status', 'off')

$(document).on 'click', '.js-toggle-search-result-details', ->
  $toggle = $(this)
  $result = $toggle.closest('.js-search-result')

  switch $toggle.data('status')
    when 'loading'
      # Do nothing.
      return

    when 'on'
      toggleOFF($result, $toggle)

    else
      toggleON($result, $toggle)
