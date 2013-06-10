class AlbumsController < ApplicationController

  respond_to :json
  
  before_filter :load_left_rail

  def load_left_rail
   @load_left_rail = true
  end

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.find_by_username(params[:username]) || Album.last
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    @album.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    @album.update_attributes(params[:album])
    @album.save

    respond_to do |format|
      if @album.update_attributes(params[:album])
        # format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_user
    @viewed_user = User.find_by_username("okinawasteel")
    render :text => @viewed_user.to_json
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      # format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
