class Cart < ApplicationRecord
  has_many :lineitems, dependent: :destroy
  has_many :items, through: :lineitems
end
