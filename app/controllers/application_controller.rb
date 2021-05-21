class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def current_cart
    if current_user
      current_cart = Cart.find_or_create_by(user_id: current_user.id)
    else
      current_cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] = current_cart.id
    end
      current_cart
  end
end
