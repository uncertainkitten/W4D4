class BandsController < ApplicationController
  before_action :login_redirect

  def login_redirect
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def index
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if @band
      render :edit
    else
      flash[:errors] = ['Band not found!']
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find_by(id: params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])

    if @band
      @band.destroy
      redirect_to bands_url
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to bands_url
    end
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end