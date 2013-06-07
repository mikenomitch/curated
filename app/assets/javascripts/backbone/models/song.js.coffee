class Curate.Models.Song extends Backbone.Model
  paramRoot: 'song'

  # ----------------------------------------------
  # DEFAULTS ------------------------------------
  # ----------------------------------------------
  defaults:
    name: null
    band: null
    rating: null
    review: null
    spotify_url: null
    other_url: null
    image_url: null


  # ----------------------------------------------
  # METHODS --------------------------------------
  # ----------------------------------------------

  rating_color: (num) ->
    colors_list = ["#940513", "#D43B35", "#FF530F", "#FA7500", "#FFAB0F", "#F0D400", "#F0D400", "#CCFF00", "#9FFF05", "#00E61B"]
    return colors_list[num-1]

  getEmbed: (url_input)->
      if (/soundcloud/.test(url_input))
        @getSoundCloudCode(url_input)
      else
        if (/uri/.test(url_input))
          @getSpotifyCode(url_input)

  getSoundCloudCode: (url) ->
    $.getJSON "http://soundcloud.com/oembed/?url=#{url}", {}, (json, response) ->
      iframe_html = json.html
      shortened_url = JSON.stringify(iframe_html.match(/src=(.*)&show_artwork/)[0])
      shortened_url = shortened_url.substring(7, shortened_url.length - 1)
      alert(shortened_url.toString())
      return shortened_url.toString()

  getSpotifyCode: (url) ->
    thing = url.match(/uri(.*)/)
    thing = JSON.stringify(thing).substring(1, thing.length)
    return thing

  embedDiv: (stored_url)->
    if (/soundcloud/.test(stored_url))
        return '<iframe width="281" height="281" scrolling="no" frameborder="no" src="'+stored_url+'=true&auto_play=false&show_user=false&show_comments=false&liking=false&buying=false&sharing=false"></iframe>'
    else
      if (/uri/.test(stored_url) || /spotify/.test(stored_url))
        return '<iframe src="https://embed.spotify.com/?uri='+stored_url+'&view=coverart" width="281" height="281" frameborder="0" allowtransparency="true"></iframe>'

class Curate.Collections.SongsCollection extends Backbone.Collection
  model: Curate.Models.Song
  url: '/songs'
