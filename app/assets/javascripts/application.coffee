#= require bower_components/jquery/dist/jquery
#= require bower_components/lodash/lodash
#= require jade/runtime
#= require_tree ../templates

$document = $(document)

$document.on 'change', '#search-phrase', ->
  $phrase = $(this)

  $('#search-outlet').html JST['search/loading']()

  jqXHR = $.getJSON('/api/search/' + encodeURIComponent($phrase.val()))
  jqXHR
    .done -> $('#search-outlet').html JST['search/results'](jqXHR.responseJSON)
    .fail -> $('#search-outlet').html JST['search/failure']()
