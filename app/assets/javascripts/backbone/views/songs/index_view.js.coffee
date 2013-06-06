Curate.Views.Songs ||= {}

class Curate.Views.Songs.IndexView extends Backbone.View
  template: JST["backbone/templates/songs/index"]

  initialize: () ->
    @options.songs.bind('reset', @addAll)

  addAll: () =>
    @options.songs.each(@addOne)

  addOne: (song) =>
    view = new Curate.Views.Songs.SongView({model : song})
    @$("tbody").prepend(view.render().el)

  sideBarRender: () ->
    $("#user_name").html(thisUser)
    $("#song_selector").html('<a href="/'+thisUser+'/songs" class="no_special_hover whitened"> Songs </a>')
    $("#album_selector").html('<a href="/'+thisUser+'/albums" class="no_special_hover whitened"> Albums </a>')

  render: =>
    @$el.html(@template(songs: @options.songs.toJSON() ))
    @sideBarRender()
    @addAll()


    return this