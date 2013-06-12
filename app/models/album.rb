class Album < ActiveRecord::Base
  attr_accessible :rating, :name, :band, :band_id, :input_url, :embed_url, :review, :image_url, :user, :user_id
  belongs_to :user
  before_save :set_embed_input
  

  def self.find_by_username(username)
    all.reject{|e| e.user == nil}.select{|e| e.user.username == username}
  end

  def set_embed_input
    puts "this is the input_url"
    puts self.input_url
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

  def setSoundCloudCode
    response = HTTParty.get("http://soundcloud.com/oembed/?url=https://soundcloud.com/taylorswiftofficial/holy-ground-1", :query => {:oauth_token => "abc"})
    json = JSON.parse(response.body)
    puts json
  #   hi = $.getJSON "http://soundcloud.com/oembed/?url=#{url}", {}, (json, response) =>
  #     iframe_html = json.html
  #     shortened_url = JSON.stringify(iframe_html.match(/src=(.*)&show_artwork/)[0])
  #     shortened_url = shortened_url.substring(7, shortened_url.length - 1)
  #     return "goosefraba"
  #     @set("input_url", shortened_url)
    self.embed_url = "https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F66142450"
  end

  def setSpotify
    # Example URI
    # spotify:track:1fGsZsIkQkOspfsT24nQP6
    # Examply Embed Code
    # <iframe src="https://embed.spotify.com/?uri=spotify:track:1fGsZsIkQkOspfsT24nQP6" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>
    # Example HTTP Link
    # http://open.spotify.com/track/1fGsZsIkQkOspfsT24nQP6
  #   shortened_url = url.match(/uri(.*)/)
  #   shortened_url = JSON.stringify(shortened_url).substring(1, shortened_url.length)
  #   @set("input_url", shortened_url)
    self.embed_url = "spotify:track:1fGsZsIkQkOspfsT24nQP6"
  end

  def setYouTubeCode
    # http://www.youtube.com/watch?v=_0nNX8upRfE
  #   ytid = JSON.stringify(url.match(/v=(.){11}/)[0])
  #   # if you want to eliminate the v= then include the next line
  #   # ytid = ytid[ 2..11]
  #   @set("input_url", ytid)
    self.embed_url = "_0nNX8upRfE"
  end

end
