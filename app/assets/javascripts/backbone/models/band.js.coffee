class Curate.Models.Band extends Backbone.RelationalModel
  paramRoot: 'band'
  urlRoot: "/bands"
  idAttribute: "id"

  # ----------------------------------------------
  # DEFAULTS ------------------------------------
  # ----------------------------------------------
  defaults:
    name: null
    default_url: null
    albums: []
    songs: []

  # ----------------------------------------------
  # RELATIONS ------------------------------------
  # ----------------------------------------------
  relations: [{
    type: Backbone.HasMany,
    key: "albums",
    relatedModel: "Prelang.Models.Album",
    collectionType: "Prelang.Collections.AlbumsCollection",
    autoFetch: true,
    reverseRelation: {
      key: "band_id",
      includeInJson: "id"
    },
    type: Backbone.HasMany,
    key: "songs",
    relatedModel: "Prelang.Models.Song",
    collectionType: "Prelang.Collections.SongsCollection",
    autoFetch: true,
    reverseRelation: {
      key: "band_id",
      includeInJson: "id"
    }
  }]

  # ----------------------------------------------
  # CALLBACKS ------------------------------------
  # ----------------------------------------------

class Curate.Collections.BandsCollection extends Backbone.Collection
  model: Curate.Models.Band
  url: '/bands'
