class PagesController < ApplicationController
  def index
    @load_left_rail = true
    @hide_search = true
  end
end