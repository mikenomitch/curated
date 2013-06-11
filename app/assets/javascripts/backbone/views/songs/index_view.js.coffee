Curate.Views.Songs ||= {}

class Curate.Views.Songs.IndexView extends Backbone.View
  template: JST["backbone/templates/songs/index"]
  no_songs_template: JST["backbone/templates/songs/no_songs"]

  events:
    "click .first_album_button" : "hidePrompt"

  initialize: () ->
    @options.songs.bind('reset', @addAll)

  hidePrompt: ->
    @$("#make_album_prompt").hide()

  noSongs: =>
    @$("#albums-table").prepend(@no_songs_template)

  addAll: () =>
    @options.songs.each(@addOne)

  addOne: (song) =>
    view = new Curate.Views.Songs.SongView({model : song})
    @$("tbody").prepend(view.render().el)

  sideBarRender: () ->
    $("#user_name").html(thisUser)
    $("#song_selector").html('<a href="/'+thisUser+'/songs" class="no_special_hover whitened"> Songs </a>')
    $("#album_selector").html('<a href="/'+thisUser+'/albums" class="no_special_hover whitened"> Albums </a>')

  addButtonRender: ->
    this.$("#new_album_button").html('<a href="#/new" class="no_special_hover"><i class="icon-plus-sign add_video_icon"> </i></a>')

  render: =>
    if thisUser == ""
      window.location = "/"
    else
      # if @options.songs.toJSON().length == 0
      # @$el.html(@template("fraba")
      # else
      @$el.html(@template(songs: @options.songs.toJSON() ))
      @sideBarRender()
      @addAll()
      if showAdd == true
        @addButtonRender()
    return this