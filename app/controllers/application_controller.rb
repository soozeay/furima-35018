class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day])
  end

  def current_cart
    current_cart = Cart.find_or_create_by(user_id: current_user.id)
    current_cart
  end

  def set_search
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
