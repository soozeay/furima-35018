class Cart < ApplicationRecord
  has_many :lineitems, dependent: :destroy
  has_many :items, through: :lineitems

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
