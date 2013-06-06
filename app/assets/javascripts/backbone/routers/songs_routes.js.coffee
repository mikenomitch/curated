class Curate.Routers.SongsRouter extends Backbone.Router
  initialize: (options) ->
    @songs = new Curate.Collections.SongsCollection()
    @songs.reset options.songs

  routes:
    "new"      : "newAlbum"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAlbum: ->
    @view = new Curate.Views.Songs.NewView(collection: @songs)
    $("#songs-table").prepend(@view.render().el)

  index: ->
    @view = new Curate.Views.Songs.IndexView(songs: @songs)
    $("#songs").html(@view.render().el)

  show: (id) ->
    song = @songs.get(id)
    @view = new Curate.Views.Songs.SongView(model: song)
    $("#songs").html(@view.render().el)

  edit: (id) ->
    song = @songs.get(id)

    @view = new Curate.Views.Songs.EditView(model: song)
    $("#song_"+id).html(@view.render().el)
