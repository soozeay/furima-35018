class Coupon < ApplicationRecord
  belongs_to :user

  enum is_valid: { '有効': true, '無効': false }

  def self.coupon_create(user)
    coupon = Coupon.new(user_id: user.id, limit: 1)
    coupon.save
  end

  def self.coupon_destroy
    time = Time.now
    coupons = Coupon.all
    coupons.each do |coupon|
      if coupon.created_at + coupon.limit.days < time && coupon.is_valid == '有効'
        coupon.is_valid = '無効'
        coupon.save
      end
    end
  end
  
end
