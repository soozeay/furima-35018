class Content < ActiveHash::Base
  self.data = [
    { id: 1, name: '50% OFF' },
    { id: 2, name: '10% OFF' },
    { id: 3, name: '500円 OFF' }
  ]
  include ActiveHash::Associations
  has_many :coupons
end
