Curate.Views.Songs ||= {}

class Curate.Views.Songs.EditView extends Backbone.View
  template: JST["backbone/templates/songs/edit"]

  events:
    "submit #edit-song": "update"
    "click .back_button": "update"
    "change #rating": "change_rating"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset("created_at", { silent: true });
    @model.unset("updated_at", { silent: true });
    @model.save(null,
      success: (song) =>
        @model = song
        Backbone.history.navigate('', true)
        fauxAlert("Song Saved")
    )

  change_rating: ->
    rating = $("#rating").val()
    if rating == "10" || 10
      $("#sliderAmount").css("letter-spacing","-20px")
      $("#sliderAmount").css("padding-right","20px")
    else
      $("#sliderAmount").css("letter-spacing","normal")        
      $("#sliderAmount").css("padding-right","0px")        
    $("#sliderAmount").html(rating)
    $("#sliderAmount").css("background-color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  render: ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    this.$("form").backboneLink(@model)
    if @model.attributes.rating == 10
      @$("#sliderAmount").css("letter-spacing","-20px")
      @$("#sliderAmount").css("padding-right","20px")
    return this