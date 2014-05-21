ready = ->
  $( '.datepicker' ).datetimepicker()

$( document ).ready( ready )
$( document ).on( 'page:load', ready )
