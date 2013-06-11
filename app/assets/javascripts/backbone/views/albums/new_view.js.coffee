Curate.Views.Albums ||= {}

class Curate.Views.Albums.NewView extends Backbone.View
  template: JST["backbone/templates/albums/new"]

  events:
    "submit #new-album": "save"
    "change #rating": "change_rating"
    "click #cancel": "cancelAndReturn"

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
        Backbone.history.navigate('', true)
      error: (album, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  cancelAndReturn: ->
    Backbone.history.navigate('', true)

  change_rating: ->
    rating = $("#rating").val()
    if rating == "10"
      $("#sliderAmount").css("letter-spacing","-20px")
      $("#sliderAmount").css("padding-right","20px")
    else
      $("#sliderAmount").css("letter-spacing","normal")        
      $("#sliderAmount").css("padding-right","0px")
    $("#sliderAmount").html($("#rating").val())
    $("#sliderAmount").css("background-color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
