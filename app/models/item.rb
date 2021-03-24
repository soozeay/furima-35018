class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :desc
    validates :price
  end
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true, numericality: { other_than: 0 }  do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :esd_id
  end

end