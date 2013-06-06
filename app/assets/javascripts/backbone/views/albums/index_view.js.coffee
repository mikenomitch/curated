Curate.Views.Albums ||= {}

class Curate.Views.Albums.IndexView extends Backbone.View
  template: JST["backbone/templates/albums/index"]

  initialize: () ->
    @options.albums.bind('reset', @addAll)

  addAll: () =>
    @options.albums.each(@addOne)

  addOne: (album) =>
    view = new Curate.Views.Albums.AlbumView({model : album})
    @$("tbody").prepend(view.render().el)

  getName: ->
     # name = $.get '/okinawasteel/albums/2'
     # JSON.stringify(name)
     "OkinawaSteel"

  sideBarRender: ->
    $("#user_name").html(thisUser)
    $("#song_selector").html('<a href="/'+thisUser+'/songs" class="no_special_hover whitened"> Songs </a>')
    $("#album_selector").html('<a href="/'+thisUser+'/albums" class="no_special_hover whitened"> Albums </a>')

  render: =>
    json = $.extend(@options.albums.toJSON(), {username: @getName()})
    @$el.html(@template(json))
    @sideBarRender()
    @addAll()

    return this