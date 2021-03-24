class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :desc
    validates :price
  end
  belongs_to: user
  
  extend Activehash::Associations::ActiveRecordExtentions
  belongs_to: category
  has_one: status
  has_one: shipping_fee
  has_many: prefecture
  has_one: esd
end