Curate.Views.Songs ||= {}

class Curate.Views.Songs.EditView extends Backbone.View
  template: JST["backbone/templates/songs/edit"]

  events:
    "submit #edit-song": "update"
    "change #rating": "change_rating"
    "blur #embed_link": "getEmbed"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(null,
      success: (song) =>
        @model = song
        window.location.hash = "/#{@model.id}"
      error: (project, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
        console.log("there was an error")
    )

  change_rating: ->
    $("#sliderAmount").html($("#rating").val())
    $("#sliderAmount").css("color",@model.rating_color($("#rating").val()))
    $(".rating_header").css("color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  render: ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    this.$("form").backboneLink(@model)
    return this

  getEmbed: ->
    url_input = $("#embed_link").val()
    if (/soundcloud/.test(url_input))
      @model.setSoundCloudCode(url_input)
    else
      if (/uri/.test(url_input))
        @model.setSpotifyCode(url_input)