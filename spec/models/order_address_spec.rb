require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @item.user_id, item_id: @item.id)
    sleep 0.5
  end

  describe 'クレジットカード決済' do
    context '登録できるとき' do
      it 'フォームの情報が全てあれば登録できる' do
        expect(@order_address).to be_valid
      end
      it '建物名が空欄でも登録できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '登録できないとき' do
      it 'トークンが空では登録できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では登録できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがないと登録できない' do
        @order_address.postal_code = '1111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（全角数字）' do
        @order_address.postal_code = '１１１-１１１１'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（英字）' do
        @order_address.postal_code = Faker::Lorem.characters(number: 3,
                                                             min_alpha: 3) + '-' + Faker::Lorem.characters(number: 4,
                                                                                                           min_alpha: 4)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便区番号が3桁でないと登録できない' do
        @order_address.postal_code = Faker::Lorem.characters(number: 2,
                                                             min_numeric: 2) + '-' + Faker::Lorem.characters(number: 4,
                                                                                                             min_numeric: 4)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
        @order_address.postal_code = Faker::Lorem.characters(number: 4,
                                                             min_numeric: 4) + '-' + Faker::Lorem.characters(number: 4,
                                                                                                             min_numeric: 4)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号の町域番号が4桁でないと登録できない' do
        @order_address.postal_code = Faker::Lorem.characters(number: 3,
                                                             min_numeric: 3) + '-' + Faker::Lorem.characters(number: 3,
                                                                                                             min_numeric: 3)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
        @order_address.postal_code = Faker::Lorem.characters(number: 3,
                                                             min_numeric: 3) + '-' + Faker::Lorem.characters(number: 5,
                                                                                                             min_numeric: 5)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（全角英字）' do
        @order_address.postal_code = 'ａａａ-ａａａａ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（漢字）' do
        @order_address.postal_code = '亞亞亞-亞亞亞亞'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（平仮名）' do
        @order_address.postal_code = 'あいう-えおかき'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外では登録できない（カタカナ）' do
        @order_address.postal_code = 'アイウ-エオカキ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県idが空では登録できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture is not a number')
      end
      it '都道府県のid:0では登録できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 0')
      end
      it '市区町村が空では登録できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では登録できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では登録できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は半角数字以外は登録できない（全角数字）' do
        @order_address.phone_number = '１２３４５６７８９８７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is not a number')
      end
      it '電話番号は半角数字以外は登録できない（漢字）' do
        @order_address.phone_number = '亞亞亞亞亞亞亞亞亞亞亞'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is not a number')
      end
      it '電話番号は半角数字以外は登録できない（平仮名）' do
        @order_address.phone_number = 'あいうえおかきくけこさ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is not a number')
      end
      it '電話番号は半角数字以外は登録できない（カタカナ）' do
        @order_address.phone_number = 'アイウエオカキクケコサ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is not a number')
      end
      it '電話番号は9桁ないと登録できない' do
        @order_address.phone_number = Faker::Lorem.characters(number: 10, min_numeric: 10)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
        @order_address.phone_number = Faker::Lorem.characters(number: 12, min_numeric: 12)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'ハイフンが入っていては登録できない' do
        @order_address.phone_number = '090-1111-1111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'user_idが空では登録できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
