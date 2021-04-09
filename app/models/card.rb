class Card < ApplicationRecord
  with_options presence:true do
    validates :card_token
    validates :customer_token
  end
  
  belongs_to :user
end
