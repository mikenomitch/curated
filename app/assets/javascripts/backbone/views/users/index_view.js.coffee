Curate.Views.Users ||= {}

class Curate.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/albums/index"]
  no_albums_template: JST["backbone/templates/albums/no_albums"]

  events:
    "click .first_album_button" : "hidePrompt"

  # player_ids: []

  # push_id:(album) ->
  #   @player_ids.push(album.id)

  initialize: () ->
    @options.albums.bind('reset', @addAll)

  hidePrompt: ->
    @$("#make_album_prompt").hide()

  noAlbums: =>
    @$("#albums-table").prepend(@no_albums_template)

  addAll: () =>
    # @options.albums.each(@push_id)
    @options.albums.each(@addOne)

  addOne: (album) =>
    view = new Curate.Views.Albums.AlbumView({model : album})
    @$("tbody").prepend(view.render().el)
    # This exists if you can check for hover easily
    # view.checkForHover()

  # closePlayers: (exception)->
  #   @player_ids - [exception]
  #   @player_ids.each(@close)

  # close: (id) ->
  #   $("#song_"+id+"_image").show()
  #   $("#song_"+id+"_player").hide()
  #   SC.Widget("widget_"+id).pause()

  sideBarRender: ->
    $("#user_name").html(thisUser)
    $("#album_selector").html('<a href="/'+thisUser+'/albums" class="no_special_hover whitened"> Albums </a>')
    $("#song_selector").html('<a href="/'+thisUser+'/songs" class="no_special_hover whitened"> Songs </a>')
    if (thisUserSongCount == 0 && showAdd != true)
      $("#song_selector").hide()

  addButtonRender: ->
    this.$("#new_album_button").html('<a href="#/new" class="no_special_hover"><i class="icon-plus-sign add_video_icon"> </i></a>')

  render: =>
    if thisUser == ""
      window.location = "/"
    else
      if @options.albums.toJSON().length == 0
        if showAdd == true
          @$el.html(@template(albums: @options.albums.toJSON() ))
          @sideBarRender()
          @noAlbums()
        else 
          if thisUserSongCount > 0
            window.location = "/"+thisUser+"/songs"
          else
            window.location = "/"
      else
        @$el.html(@template(albums: @options.albums.toJSON() ))
        @sideBarRender()
        @addAll()
        if showAdd == true
          @addButtonRender()

    return this