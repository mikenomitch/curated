Curate.Views.Albums ||= {}

class Curate.Views.Albums.NewView extends Backbone.View
  template: JST["backbone/templates/albums/new"]

  events:
    "submit #new-album": "save"
    "change #rating": "change_rating"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (album) =>
        @model = album
        window.location.hash = "/#{@model.id}"

      error: (album, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  change_rating: ->
    $("#sliderAmount").html($("#rating").val())
    $("#sliderAmount").css("color",@model.rating_color($("#rating").val()))
    $(".rating_header").css("color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
