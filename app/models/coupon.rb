class Coupon < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :content
  validates :content_id, presence: true


  enum is_valid: { '有効': true, '無効': false }

  def coupon_create
    @users = User.where(id: (Order.order("RAND()").limit(3)).user_id)
    @users.each do |i|
      coupon = Coupon.create(user_id: user.id, content_id: i, limit: 1)
    end
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
