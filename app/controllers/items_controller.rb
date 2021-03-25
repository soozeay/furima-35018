class ItemsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :desc, :price, :category_id, :status_id, :shippingfee_id, :prefecture_id, :esd_id,
                                 :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
