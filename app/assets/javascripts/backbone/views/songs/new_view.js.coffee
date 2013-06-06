Curate.Views.Songs ||= {}

class Curate.Views.Songs.NewView extends Backbone.View
  template: JST["backbone/templates/songs/new"]

  events:
    "submit #new-song": "save"
    "change #rating": "change_rating"
    "click #buttony": "testSaving"

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
      success: (song) =>
        alert("success?")
        @model = song
        window.location.hash = "/#{@model.id}"
        alert("success2")

      error: (song, jqXHR) =>
        alert(JSON.stringify(@model.toJSON()))
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  testSaving: () ->
    @model.unset("errors")
    object =
      "name":"f",
      "band":"d",
      "band_id":null,
      "rating":"6",
      "review":"ccce",
      "spotify_url":null,
      "other_url":null,
      "image_url":"http://www.google.com"
    @collection.create(object,
      success: (song) =>
        alert("success?")
      error:(song) =>
        alert("failure")
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


# {"name":"f","band":"d","band_id":null,"rating":"6","review":"ccce","spotify_url":null,"other_url":null,"image_url":"http://www.google.com"}