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
    input_url = @model.get("spotify_url")
    @model.unset("errors")
    @model.set("spotify_url", @getEmbed(input_url))

    @collection.create(@model.toJSON(),
      success: (song) =>
        @model = song
        Backbone.history.navigate('', true)
      error: (song, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  cancelAndReturn: ->
    Backbone.history.navigate('', true)

  getEmbed: (url_input)->
      if (/soundcloud/.test(url_input))
        @getSoundCloudCode(url_input)
      else
        if (/uri/.test(url_input))
          @getSpotifyCode(url_input)
        else
          if (/youtu/.test(url_input))
            @getYouTubeCode(url_input)

  getSoundCloudCode: (url) ->
    $.getJSON "http://soundcloud.com/oembed/?url=#{url}", {}, (json, response) ->
      iframe_html = json.html
      shortened_url = JSON.stringify(iframe_html.match(/src=(.*)&show_artwork/)[0])
      shortened_url = shortened_url.substring(7, shortened_url.length - 1)
      # alert shortened_url.toString()
      @model.set("spotify_url", "https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F42845570&show_artwork")

  getSpotifyCode: (url) ->
    thing = url.match(/uri(.*)/)
    thing = JSON.stringify(thing).substring(1, thing.length)
    return thing

  getYouTubeCode: (url) ->
    ytid = JSON.stringify(url.match(/v=(.){11}/)[0])
    # if you want to eliminate the v= then include the next line
    # ytid = ytid[ 2..11]
    return ytid


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