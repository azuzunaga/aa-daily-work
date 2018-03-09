class BandsController < ApplicationController
  # new create update edit destroy show index

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
  end

  def update

  end

  def edit

  end

  def destroy

  end

  def show

  end

  def index
    render :index
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
