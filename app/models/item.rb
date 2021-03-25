class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :desc
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true, numericality: { other_than: 0 }  do
    validates :category_id
    validates :status_id
    validates :shippingfee_id
    validates :prefecture_id
    validates :esd_id
  end

  belongs_to :category
  belongs_to :status
  belongs_to :shippingfee
  belongs_to :prefecture
  belongs_to :esd

end