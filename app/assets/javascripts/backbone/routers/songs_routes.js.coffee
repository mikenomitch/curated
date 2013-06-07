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
    @renderIndexIfItIsntThere()
    @view = new Curate.Views.Songs.NewView(collection: @songs)
    $("#songs-table").prepend(@view.render().el)

  index: ->
    @view = new Curate.Views.Songs.IndexView(songs: @songs)
    $("#songs").html(@view.render().el)

  show: (id) ->
    # I am just directing to the index view b/c it'll never be necessary to go to the song itself
    @view = new Curate.Views.Songs.IndexView(songs: @songs)
    $("#songs").html(@view.render().el)
    # song = @songs.get(id)
    # @view = new Curate.Views.Songs.SongView(model: song)
    # $("#songs").html(@view.render().el)

  edit: (id) ->
    @renderIndexIfItIsntThere()
    song = @songs.get(id)
    @view = new Curate.Views.Songs.EditView(model: song)
    $("#song_"+id).html(@view.render().el)

  renderIndexIfItIsntThere: ->
    unless ($("#songs-table").length > 0)
      @had_to_rerender = true
      @view = new Curate.Views.Songs.IndexView(songs: @songs)
      $("#songs").html(@view.render().el)