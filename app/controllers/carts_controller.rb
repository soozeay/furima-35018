class CartsController < ApplicationController
  before_action :set_line_item, only: [:create, :destroy]

  def show
    @line_items = current_cart.lineitems
  end

  def create
    @line_item = current_cart.lineitems.build(item_id: params[:item][:item_id])
    @line_item.quantity += params[:quantity].to_i
    @item = Item.find(params[:item][:item_id])
    binding.pry
    if @line_item.valid? && @line_item.quantity <= @item.stock
      @line_item.save
      redirect_to item_path(@line_item.item_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @cart.destroy
    redirect_to root_path
  end

  private

  def set_line_item
    @line_item = current_cart.lineitems.find_by(item_id: params[:item_id])
  end

end