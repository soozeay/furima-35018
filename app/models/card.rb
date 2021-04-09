class Card < ApplicationRecord
  with_options presence:true do
    validates :card_token
  end
  
  belongs_to :user
end
