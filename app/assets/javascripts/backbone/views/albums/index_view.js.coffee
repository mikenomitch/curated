Curate.Views.Albums ||= {}

class Curate.Views.Albums.IndexView extends Backbone.View
  template: JST["backbone/templates/albums/index"]
  no_albums_template: JST["backbone/templates/albums/no_albums"]

  events:
    "click .first_album_button" : "hidePrompt"

  initialize: () ->
    @options.albums.bind('reset', @addAll)

  hidePrompt: ->
    @$("#make_album_prompt").hide()

  noAlbums: =>
    @$("#albums-table").prepend(@no_albums_template)

  addAll: () =>
    @options.albums.each(@addOne)

  addOne: (album) =>
    view = new Curate.Views.Albums.AlbumView({model : album})
    @$("tbody").prepend(view.render().el)

  sideBarRender: ->
    $("#user_name").html(thisUser)
    $("#song_selector").html('<a href="/'+thisUser+'/songs" class="no_special_hover whitened"> Songs </a>')
    $("#album_selector").html('<a href="/'+thisUser+'/albums" class="no_special_hover whitened"> Albums </a>')

  render: =>
    if @options.albums.toJSON().length == 0
      @$el.html(@template(albums: @options.albums.toJSON() ))
      @sideBarRender()
      @noAlbums()
    else
      @$el.html(@template(albums: @options.albums.toJSON() ))
      @sideBarRender()
      @addAll()

    return this