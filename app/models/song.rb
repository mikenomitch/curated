class Song < ActiveRecord::Base
  attr_accessible :rating, :name, :band, :band_id, :spotify_url, :other_url, :review, :image_url, :user, :user_id
  belongs_to :user

  def self.find_by_username(username)
    all.reject{|e| e.user == nil}.select{|e| e.user.username == username}
  end
  
end
