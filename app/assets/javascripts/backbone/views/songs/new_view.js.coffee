Curate.Views.Songs ||= {}

class Curate.Views.Songs.NewView extends Backbone.View
  template: JST["backbone/templates/songs/new"]

  events:
    "submit #new-song": "save"
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
    input_url = @model.get("spotify_url")
    new_spotty = @model.getEmbed(input_url)   
    @model.set("spotify_url", "https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F42845570&show_artwork")

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (song) =>
        @model = song
        Backbone.history.navigate('', true)
      error: (song, jqXHR) =>
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