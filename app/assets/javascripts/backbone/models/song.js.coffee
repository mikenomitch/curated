class Curate.Models.Song extends Backbone.Model
  paramRoot: 'song'
  urlRoot: "/songs"
  idAttribute: "id"

  # ----------------------------------------------
  # DEFAULTS ------------------------------------
  # ----------------------------------------------
  defaults:
    name: null
    band: null
    band_id: null
    rating: null
    review: null
    spotify_url: null
    other_url: null
    image_url: null


  # ----------------------------------------------
  # METHODS --------------------------------------
  # ----------------------------------------------

  rating_color: (num) ->
    colors_list = ["#940513", "#FF1A05", "#FF530F", "#FA7500", "#FFAB0F", "#F0D400", "#F0D400", "#CCFF00", "#9FFF05", "#00E61B"]
    return colors_list[num-1]

  setSoundCloudCode: (url) ->
    $.getJSON "http://soundcloud.com/oembed/?url=#{url}", {}, (json, response) ->
      iframe_html = json.html
      shortened_url = JSON.stringify(iframe_html.match(/src=(.*)&show_artwork/))
      shortened_url = shortened_url.substring(7, shortened_url.length - 1)
      alert(shortened_url)

  setSpotifyCode: (url) ->
    thing = url.match(/uri(.*)/)
    alert(thing)

class Curate.Collections.SongsCollection extends Backbone.Collection
  model: Curate.Models.Song
  url: '/songs'
