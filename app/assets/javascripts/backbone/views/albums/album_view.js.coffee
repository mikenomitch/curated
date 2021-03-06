Curate.Views.Albums ||= {}

class Curate.Views.Albums.AlbumView extends Backbone.View
  template: JST["backbone/templates/albums/album"]

  events:
    "click .destroy" : "destroy"
    "click .album-image" : "showPlayer"
    "mouseenter .album-image" : "showPlayButton"
    "mousemove .album-image" : "showPlayButton"
    "mouseenter .play_button" : "showPlayButton"
    "hover .play_button" : "showPlayButton"
    "mouseout .album-image" : "hidePlayButton"
    "hover .tile" : "hidePlayButton"
    "click .play_button" : "showPlayer"

  tagName: "tr"

  destroy: () ->
    if confirm "Are you sure you want to delete this album?"
      @model.destroy()
      this.remove()
      fauxRedAlert("This album has been deleted.")
      return false

  render: () ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating), embedDiv: @model.embedDiv(@model.attributes.embed_url), showEdit: true})
    @$el.html(@template(json))
    @$(".hidden_player").html(@model.embedDiv(@model.attributes.embed_url,@model.attributes.id ))
    @$("#edit_holder").html(@showEdit(window.showAdd, @model.attributes.id, window.currentUser))
    if @model.attributes.rating == 10
      @$(".album-rating").css("letter-spacing","-8px")
      @$(".album-rating").css("padding-right","14px")
    return this

  playButtonShowable: true

  embedExists: () ->
    if @model.attributes.embed_url == "error"
      false
    else
      true

  showEdit: (showIt,id, username) ->
    if showIt == true
      '<a class="edit_link" href="/'+username+'/albums#'+id+'/edit"> <span class="nav_link"><i class="icon-cog icon_and_edit"> Edit</i></span> </a>'

  showPlayButton: ->
    if @embedExists()
      if @playButtonShowable == true
        $("#play_button_for_"+@model.attributes.id).show()
        hide: { fixed: true }
      if @playButtonShowable == false
        @hidePlayButton

  hidePlayButton: ->
    $("#play_button_for_"+@model.attributes.id).hide()    

  showPlayer: ->
    if @embedExists()
      $("#play_button_for_"+@model.attributes.id).hide()
      $("#album_"+@model.attributes.id+"_image").hide()
      $("#album_"+@model.attributes.id+"_player").show()
      SC.Widget("widget_"+@model.attributes.id).play()
      @playButtonShowable = false
