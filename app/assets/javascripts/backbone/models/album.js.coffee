class Curate.Models.Album extends Backbone.Model
  paramRoot: 'album'

  # ----------------------------------------------
  # DEFAULTS ------------------------------------
  # ----------------------------------------------

  defaults:
    name: null
    band: null
    rating: null
    review: null
    input_url: null
    embed_url: null
    image_url: null

  # ----------------------------------------------
  # METHODS --------------------------------------
  # ----------------------------------------------

  rating_color: (num) ->
    colors_list = ["#940513", "#D43B35", "#FF530F", "#FA7500", "#FFAB0F", "#F0D400", "#F0D400", "#CCFF00", "#9FFF05", "#00E61B"]
    return colors_list[num-1]

  embedDiv: (stored_url, id)->
    if (/soundcloud/.test(stored_url))
        return '<iframe id="widget_'+id+'" width="281" height="281" scrolling="no" frameborder="no" src="'+stored_url+'&show_artwork=true&auto_play=false&show_user=false&show_comments=false&liking=false&buying=false&sharing=false&show_playcount=false"></iframe>'
    else
      if (/uri/.test(stored_url) || /spotify/.test(stored_url))
        return '<iframe id="widget_'+id+'" src="https://embed.spotify.com/?uri='+stored_url+'" width="281" height="281" frameborder="0" allowtransparency="true"></iframe><div class="spotify_disclaimer">Note: This will open Spotify</div>'
      else
        return '<iframe id="widget_'+id+'" width="281" height="281" src="http://www.youtube.com/embed/'+stored_url+'" frameborder="0" allowfullscreen></iframe>'





  # ----------------------------------------------
  # CALLBACKS --------------------------------------
  # ----------------------------------------------


# ------------------------------------------------
# ------------------------------------------------
# ------------------------------------------------
    
class Curate.Collections.AlbumsCollection extends Backbone.Collection
  model: Curate.Models.Album
  url: '/albums'