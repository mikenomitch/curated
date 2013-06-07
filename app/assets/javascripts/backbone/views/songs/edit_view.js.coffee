Curate.Views.Songs ||= {}

class Curate.Views.Songs.EditView extends Backbone.View
  template: JST["backbone/templates/songs/edit"]

  events:
    "submit #edit-song": "update"
    "change #rating": "change_rating"
    "click .back_button": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset("created_at", { silent: true });
    @model.unset("updated_at", { silent: true });
    @model.save(null,
      success: (song) =>
        @model = song
        Backbone.history.navigate('', true)
    )

  change_rating: ->
    $("#sliderAmount").html($("#rating").val())
    $("#sliderAmount").css("background-color",@model.rating_color($("#rating").val()))
    # $(".rating_header").css("color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  render: ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    this.$("form").backboneLink(@model)
    return this