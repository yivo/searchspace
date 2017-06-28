#= require bower_components/jquery/dist/jquery
#= require bower_components/lodash/lodash
#= require jade/runtime
#= require_tree ../templates

$document = $(document)

$document.on 'change', '#search-phrase', ->
  $phrase = $(this)

  $('#search-outlet').html JST['search/loading-indicator']()

  jqXHR = $.getJSON('/api/search/' + encodeURIComponent($phrase.val()))
  jqXHR
    .done ->
      $('#search-outlet').html JST['search/results'](jqXHR.responseJSON)
    .fail ->
      _.tap $('#search-outlet'), ($outlet) ->
        if jqXHR.readyState is 0
          $outlet.html JST['search/network-error']()
        else
          $outlet.html JST['search/server-error']()
