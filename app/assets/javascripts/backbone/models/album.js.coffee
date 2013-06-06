class Curate.Models.Album extends Backbone.Model
  paramRoot: '/users/okinawasteel/albums/'
  urlRoot: "/users/okinawasteel/albums/"
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

  # ----------------------------------------------
  # CALLBACKS --------------------------------------
  # ----------------------------------------------


# ------------------------------------------------
# ------------------------------------------------
# ------------------------------------------------
    
class Curate.Collections.AlbumsCollection extends Backbone.Collection
  model: Curate.Models.Album
  url: '/albums'