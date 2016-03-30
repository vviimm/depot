class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize

  include ActionView::Helpers::TextHelper

  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end


    # @count = session_count
    # @session_greeting_msg = session_greeting
    #   if @count > 5
    #     flash[:notice] = @session_greeting_msg
    #   end
  end

  private

    def session_count
      session[:counter] ||= 0
      session[:counter] += 1
    end

    def session_greeting
      if @count == 0
        session_greeting = "welcome!"
      else
        session_greeting = "You've been here " + pluralize(@count, 'time')
      end
    end
end
