module OrdersHelper

  def choose_coupons(user)
    @coupons = user.coupons
    @contents = []
    @coupons.each do |coupon|
      @contents << coupon.content.name
    end
    return @contents
  end
end
