class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  before_action :authorize

  protected

    def authorize
      if User.count.zero?
        User.create(name: 'admin', password: 'admin', password_confirmation: 'admin')
      else
        unless User.find_by(id: session[:user_id])
        redirect_to login_path, notice: "Пожалуйста, пройдите авторизацию"
        end
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
