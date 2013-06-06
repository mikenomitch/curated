Curate.Views.Songs ||= {}

class Curate.Views.Songs.SongView extends Backbone.View
  template: JST["backbone/templates/songs/song"]

  events:
    "click .destroy" : "destroy"
    "click .album-image" : "showPlayer"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: () ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    return this

  showPlayer: ->
    $("#song_"+@model.attributes.id+"_image").hide()
    $("#song_"+@model.attributes.id+"_player").show()