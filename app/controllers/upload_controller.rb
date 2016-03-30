class UploadController < ApplicationController

  skip_before_action :authorize

  def show
    @picture = Picture.find(params[:id])
  end

  def get
    @picture = Picture.new
  end

  def save
    @picture = Picture.find(params[:id])
    if @picture.save
      redirect_to(action: 'show', id: @picture.id)
    else
      render(action: :get)
    end
  end

  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data,
              filename: @picture.name,
              type: @picture.content_type,
              disposition: "inline")
  end

  private

  def picture_params
    params.require(:picture).permit(:comment, :uploaded_picture)
  end
end
