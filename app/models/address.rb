class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code
    validates :city
    validates :house_number
    validates :phone_number
  end
  belongs_to :order
  belongs_to :prefecture

  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :prefecture_id, presence: true, numericality: { other_than: 0 }

end