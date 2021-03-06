Curate.Views.Songs ||= {}

class Curate.Views.Songs.SongView extends Backbone.View
  template: JST["backbone/templates/songs/song"]

  events:
    "click .destroy" : "destroy"
    "click .album-image" : "showPlayer"
    "mouseover .album-image" : "showPlayButton"
    "mouseover .play_button" : "showPlayButton"
    "mousemove .album-image" : "showPlayButton"
    "hover .play_button" : "showPlayButton"
    "mouseout .album-image" : "hidePlayButton"
    "hover .tile" : "hidePlayButton"
    "click .play_button" : "showPlayer"

  tagName: "tr"

  destroy: () ->
    if confirm "Are you sure you want to delete this song?"
      @model.destroy()
      this.remove()
      fauxRedAlert("This song has been deleted.")
      return false

  render: () ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating), embedDiv: @model.embedDiv(@model.attributes.input_url), showEdit: true})
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
      '<a class="edit_link" href="/'+username+'/songs#'+id+'/edit"> <span class="nav_link"><i class="icon-cog icon_and_edit"> Edit</i></span> </a>'

  showPlayButton: ->
    if @embedExists()
      if @playButtonShowable == true
        $("#play_button_for_"+@model.attributes.id).show()
        hide: { fixed: true }
      else
        @hidePlayButton

  hidePlayButton: ->
    $("#play_button_for_"+@model.attributes.id).hide()    

  showPlayer: ->
    if @embedExists()
      $("#play_button_for_"+@model.attributes.id).hide()
      $("#song_"+@model.attributes.id+"_image").hide()
      $("#song_"+@model.attributes.id+"_player").show()
      SC.Widget("widget_"+@model.attributes.id).play()
      @playButtonShowable = false