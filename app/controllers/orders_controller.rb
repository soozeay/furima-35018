class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :show]
  before_action :move_to_index, except: :show

  def index
    @order_address = OrderAddress.new
    unless current_user.card.present?
      redirect_to user_path(current_user)
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      @item.stock -= @buy_quantity
      @item.save
      @line_item.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    redirect_to root_path if @item.user.id != current_user.id
    @order = Order.find(params[:id])
    @address = Address.find_by(order_id: @order.id)
    @prefecture = Prefecture.find(@address.prefecture_id)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    @line_item = Lineitem.find_by(cart_id: current_user.cart.id)
    @buy_quantity = @line_item.quantity
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price * @buy_quantity,  # 商品の値段
      customer: customer_token, # 顧客トークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_index
    redirect_to root_path if @item.user.id == current_user.id
  end
end
