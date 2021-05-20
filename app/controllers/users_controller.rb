class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    if @user.card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) 
      @card = customer.cards.first
    end
    @items = @user.items.order('created_at DESC')
    @ordered_items = @user.orders
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user) 
      redirect_to root_path 
    else
      redirect_to user_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

end
