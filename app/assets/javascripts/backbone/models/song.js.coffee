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

  embedDiv: (stored_url, id)->
    if (/soundcloud/.test(stored_url))
        return '<iframe id="widget_'+id+'" width="281" height="281" scrolling="no" frameborder="no" src="'+stored_url+'=true&auto_play=false&show_user=false&show_comments=false&liking=false&buying=false&sharing=false&show_playcount=false"></iframe>'
    else
      if (/uri/.test(stored_url) || /spotify/.test(stored_url))
        return '<iframe id="widget_'+id+'" src="https://embed.spotify.com/?uri='+stored_url+'" width="281" height="281" frameborder="0" allowtransparency="true"></iframe><div class="spotify_disclaimer">Note: This will open Spotify</div>'
      else
        if /v=/.test(stored_url)
          return '<iframe id="widget_'+id+'" width="281" height="281" src="http://www.youtube.com/embed/'+stored_url[2..12]+'" frameborder="0" allowfullscreen></iframe>'

  setEmbed: (url_input)->
    if (/soundcloud/.test(url_input))
      @getSoundCloudCode(url_input)
    else
      if (/uri/.test(url_input))
        @getSpotifyCode(url_input)
      else
        if (/youtu/.test(url_input))
          @getYouTubeCode(url_input)

  getSoundCloudCode: (url) =>
    hi = $.getJSON "http://soundcloud.com/oembed/?url=#{url}", {}, (json, response) =>
      iframe_html = json.html
      shortened_url = JSON.stringify(iframe_html.match(/src=(.*)&show_artwork/)[0])
      shortened_url = shortened_url.substring(7, shortened_url.length - 1)
      return "goosefraba"
      @set("spotify_url", shortened_url)
      

  getSpotifyCode: (url) =>
    shortened_url = url.match(/uri(.*)/)
    shortened_url = JSON.stringify(shortened_url).substring(1, shortened_url.length)
    @set("spotify_url", shortened_url)

  getYouTubeCode: (url) =>
    ytid = JSON.stringify(url.match(/v=(.){11}/)[0])
    # if you want to eliminate the v= then include the next line
    # ytid = ytid[ 2..11]
    @set("spotify_url", ytid)


class Curate.Collections.SongsCollection extends Backbone.Collection
  model: Curate.Models.Song
  url: '/songs'
