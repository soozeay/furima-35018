class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :desc
    validates :price
  end
  belongs_to: user
  has_one_attached :image

  extend Activehash::Associations::ActiveRecordExtentions
  with_options numericality: {other_than: 0} do
    belongs_to: category_id
    belongs_to: status_id
    belongs_to: shipping_fee_id
    belongs_to: prefecture_id
    belongs_to: esd_id
  end

end