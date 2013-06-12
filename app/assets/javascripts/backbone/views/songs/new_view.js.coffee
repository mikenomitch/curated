Curate.Views.Songs ||= {}

class Curate.Views.Songs.NewView extends Backbone.View
  template: JST["backbone/templates/songs/new"]

  events:
    "submit #new-song": "save"
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
    user_input_url = @model.get("temporary_url")
    @model.setEmbed(user_input_url)
    @model.unset("errors")
    @model.unset("temporary_url")
    @collection.create(@model.toJSON(),
      success: (song) =>
        @model = song
        Backbone.history.navigate('', true)
      error: (song, jqXHR) =>
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