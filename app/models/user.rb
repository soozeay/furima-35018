class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders
  has_one :card, dependent: :destroy

  validates :password, :password_confirmation, format: { with: /\A(?=.*?[a-z])(?=.*?[\d)])[a-z\d]+\z/i }

  with_options presence: true do
    validates :nickname
    validates :birth_day

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は漢字で入力してください' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
end
