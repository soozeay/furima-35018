class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :desc
    validates :price
  end
  belongs_to: user
end