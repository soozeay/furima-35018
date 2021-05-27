class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    if params[:category_id].present?
      @category_items = Item.includes(:user).where(category_id: params[:category_id])
      @items = @category_items.where.not(stock: 0).order('created_at DESC')
    else
      @items = Item.includes(:user).order('created_at DESC')
    end

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

  def show
    if @item.stock == 0
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def search
    @items = @items.where.not(stock: 0)
  end

  private

  def item_params
    params.require(:item).permit(:name, :desc, :price, :stock, :category_id, :status_id, :shippingfee_id, :prefecture_id, :esd_id,
                                 :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if @item.user_id != current_user.id
  end
end
