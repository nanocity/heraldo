TournamentsController = Paloma.controller( "Tournaments" )

TournamentsController.prototype.new = ->
  this.setup_image_selector()
TournamentsController.prototype.create = ->
  this.setup_image_selector()
TournamentsController.prototype.edit = ->
  this.setup_image_selector()
TournamentsController.prototype.update = ->
  this.setup_image_selector()
TournamentsController.prototype.show = ->
  this.toggle_army()
TournamentsController.prototype.management = ->
  this.toggle_army()


TournamentsController.prototype.setup_image_selector = ->
  if $( '#img-selector-img' ).length > 0 and $( '#img-selector-empty' ).length > 0
    if $( '#img-selector-img > img' ).attr( 'src' )
      $( '#img-selector-empty' ).hide()
    else
      $( '#img-selector-img' ).hide()

    $( '#img-selector-empty' ).click ->
      $( '#tournament_poster' ).trigger( 'click' )

    $( '#img-selector-img' ).click ->
      $( '#tournament_poster' ).trigger( 'click' )

    $( '#tournament_poster' ).change ->
      if( this.files and this.files[0] )
        reader = new FileReader()
        reader.onload = (event) ->
          $( '#img-selector-img > img' ).attr( 'src', event.target.result )
          $( '#img-selector-empty' ).hide()
          $( '#img-selector-img' ).show()
        reader.readAsDataURL( this.files[0] )

    $( '#img-selector-remove' ).click ( event ) ->
      event.stopPropagation()
      $( '#tournament_remove_poster' ).val( 'true' )
      $( '#img-selector-img' ).hide()
      $( '#img-selector-empty' ).show()


TournamentsController.prototype.toggle_army = ->
  $( '.army-form' ).hide().removeClass( 'hide' )

  toggle_list = ( (event) ->
    container = $( event.target ).closest( '.army-container' )
    container.find( '.army-form' ).toggle()
    container.find( '.army-list-container' ).toggle()
    event.preventDefault()
  )

  $( '.army-edit' ).click( toggle_list )
  $( '.army-cancel' ).click( toggle_list )

