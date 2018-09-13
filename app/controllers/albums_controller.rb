class AlbumsController < ApplicationController
  before_action :login_redirect

  def login_redirect
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    @album.band_id = params[:band_id]

    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    if @album
      render :edit
    else
      flash[:errors] = ['Album not found!']
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find_by(id: params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])

    if @album
      @album.destroy
      redirect_to bands_url
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to bands_url
    end
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end
end
