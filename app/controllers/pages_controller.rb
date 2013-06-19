class PagesController < ApplicationController
  def index
    @load_left_rail = true
    @hide_search = true
  end

  def homepage
    @load_left_rail = true
    @albums_and_songs = current_user.followings.map(&:albums) + current_user.followings.map(&:songs)
    # @albums_and_songs.sort!{|a,b| a.created_at <=> b.created_at}
  end

end