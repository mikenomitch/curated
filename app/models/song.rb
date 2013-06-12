class Song < ActiveRecord::Base
  attr_accessible :rating, :name, :band, :band_id, :input_url, :embed_url, :review, :image_url, :user, :user_id
  belongs_to :user
  before_save :set_embed_input

  def self.find_by_username(username)
    all.reject{|e| e.user == nil}.select{|e| e.user.username == username}
  end

  def set_embed_input
    
  end
  
end
