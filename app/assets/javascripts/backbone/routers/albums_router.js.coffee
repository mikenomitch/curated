class Curate.Routers.AlbumsRouter extends Backbone.Router
  initialize: (options) ->
    @albums = new Curate.Collections.AlbumsCollection()
    @albums.reset options.albums

  routes:
    "new"      : "newAlbum"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAlbum: ->
    @renderIndexIfItIsntThere()
    @view = new Curate.Views.Albums.NewView(collection: @albums)
    $("#albums-table").prepend(@view.render().el)

  index: ->
    @view = new Curate.Views.Albums.IndexView(albums: @albums)
    $("#albums").html(@view.render().el)

  show: (id) ->
    album = @albums.get(id)
    @view = new Curate.Views.Albums.ShowView(model: album)
    $("#albums").html(@view.render().el)

  edit: (id) ->
    @renderIndexIfItIsntThere()
    album = @albums.get(id)
    @view = new Curate.Views.Albums.EditView(model: album)
    $("#album_"+id).html(@view.render().el)

  renderIndexIfItIsntThere: ->
    unless ($("#albums-table").length > 0)
      @had_to_rerender = true
      @view = new Curate.Views.Albums.IndexView(albums: @albums)
      $("#albums").html(@view.render().el)