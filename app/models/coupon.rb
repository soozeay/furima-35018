class Coupon < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :content
  validates :content_id, presence: true

end
