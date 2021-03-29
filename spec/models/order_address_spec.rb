require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @item.user_id, item_id: @item.id)
  end

  describe 'クレジットカード決済（トークンの保存）' do
    context '登録できるとき' do
      it 'フォームの情報が全てあれば登録できる' do
        expect(@order_address).to be_valid
      end
      it '建物名が空欄でも登録できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
  end
end