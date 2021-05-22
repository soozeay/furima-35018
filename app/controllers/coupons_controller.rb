class CouponsController < ApplicationController

  def index
    @coupons = Coupon.where(user_id: current_user.id, is_valid: '有効') 
  end
end
