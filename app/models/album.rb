class Album < ActiveRecord::Base
  attr_accessible :rating, :name, :band, :band_id, :input_url, :embed_url, :review, :image_url, :user, :user_id
  belongs_to :user
  before_save :set_embed_input

  def self.find_by_username(username)
    all.reject{|e| e.user == nil}.select{|e| e.user.username == username}
  end

  def set_embed_input
    if self.input_url.include?("soundcloud")
      setSoundCloudCode
    elsif self.input_url.include?("uri") || self.input_url.include?("spotify")
      setSpotifyCode
    elsif self.input_url.include?("youtu")
      setYouTubeCode
    else
      self.embed_url = "error"
    end
  end

  def setNilEmbed
    self.embed_url = "no_embed"
  end

  def setSoundCloudCode
    require 'httparty'
    response = HTTParty.get('http://soundcloud.com/oembed/?url='+self.input_url)
    html = response.parsed_response["oembed"]["html"]
    parsed_embed = /src=(.*)show_artwork/.match html
    self.embed_url = parsed_embed[1][1..-2]
    # self.embed_url = "https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F37889463"
  end

  def setSpotifyCode
    # Example URI
    # spotify:track:1fGsZsIkQkOspfsT24nQP6
    # Examply Embed Code
    # <iframe src="https://embed.spotify.com/?uri=spotify:track:1fGsZsIkQkOspfsT24nQP6" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>
    # Example HTTP Link - CANT DO THIS ONE YET
    # http://open.spotify.com/track/1fGsZsIkQkOspfsT24nQP6
    url = self.input_url
    if url.include?("uri")
      shortened_url = (/uri(.*)width=/.match url)[1][1..-3]
    else
      shortened_url = url
    end
    self.embed_url = shortened_url
  end

  def setYouTubeCode
    # Example Yotube ID-
    # http://www.youtube.com/watch?v=_0nNX8upRfE
    full_url = self.input_url
    if full_url.include?("youtu.be") 
      regex = full_url.scan(/http:\/\/youtu\.be\/(?<youtube_id>.*)/)
      self.embed_url = regex[0][0]
    # If normal URL
    else
      if full_url.include?("youtube")
        query_string = URI.parse(full_url).query
        parameters = Hash[URI.decode_www_form(query_string)]
        self.embed_url = parameters["v"]
      else
        #fail "Malformed YouTube Id"
        self.embed_url = "error"
      end
    end
  end

end
