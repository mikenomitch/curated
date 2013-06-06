class Band < ActiveRecord::Base
  attr_accessible :default_image, :name, :albums, :songs, :song_id
end
