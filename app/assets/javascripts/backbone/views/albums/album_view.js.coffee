Curate.Views.Albums ||= {}

class Curate.Views.Albums.AlbumView extends Backbone.View
  template: JST["backbone/templates/albums/album"]

  events:
    "click .destroy" : "destroy"
    "click .album-image" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: () ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    return this