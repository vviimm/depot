class PhotosController < ApplicationController
  skip_before_action :authorize

  def index
    @photos = Photo.all
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save!
      render json: @photo
    else
      render json: [], status: 500
    end
  end

  def destroy
    @photo.destroy

    render nothing: true
  end

  private
    def photo_params
      params.require(:photo).permit(:image)
    end
end
