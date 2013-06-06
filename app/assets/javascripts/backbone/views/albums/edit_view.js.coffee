Curate.Views.Albums ||= {}

class Curate.Views.Albums.EditView extends Backbone.View
  template: JST["backbone/templates/albums/edit"]

  events:
    "submit #edit-album": "update"
    "change #rating": "change_rating"
    "click .back_button": "backToIndex"


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset("errors")
    @model.save(null,
      success: (album) =>
        @model = album
        window.location.hash = "/#{@model.id}"
      error: (project, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
        console.log("there was an error")
    )

  backToIndex: ->
    @model.unset("errors")
    @model.set({name:"new name"})
    @model.save({name:"new name",band:"The Moops"},
      success: (album) =>
        console.log("success")
        window.router.navigate("#/index")
      error: (project, jqXHR) =>
        console.log("there was an error")
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  change_rating: ->
    $("#sliderAmount").html($("#rating").val())
    $("#sliderAmount").css("color",@model.rating_color($("#rating").val()))
    $(".rating_header").css("color",@model.rating_color($("#rating").val()))
    $("#rating").css("background-color",@model.rating_color($("#rating").val()))

  getEmbed: ->
    the_url = $("#image_url").val()
    $.getJSON "http://soundcloud.com/oembed?callback=?#{the_url}", {}, (json, response) ->
      console.log(json)
    
  render: ->
    json = $.extend(@model.toJSON(), {rating_color: @model.rating_color(@model.attributes.rating)})
    @$el.html(@template(json))
    this.$("form").backboneLink(@model)
    return this