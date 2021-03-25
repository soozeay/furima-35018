require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができるとき' do
      it 'フォーム内の必要情報が全て存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名（name）が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明（desc）が空では登録できない' do
        @item.desc = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Desc can't be blank")
      end
      it '商品価格（price）が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '商品価格（price）が300円未満では登録できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '商品価格（price）が9,999,999円より大きければ登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '商品カテゴリ（category_id）が空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it '商品カテゴリ（category_id）のid:0では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it '商品の状態（status_id）が空では登録できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank", "Status is not a number")
      end
      it '商品の状態（status_id）のid:0では登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 0")
      end
      it '配送料の負担（shippingfee）が空では登録できない' do
        @item.shippingfee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingfee can't be blank", "Shippingfee is not a number")
      end
      it '配送料の負担（shippingfee）のid:0では登録できない' do
        @item.shippingfee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingfee must be other than 0")
      end
      it '発送元（prefecture）が空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end
      it '発送元（prefecture）のid:0では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it '配送日の目安（esd）が空では登録できない' do
        @item.esd_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Esd can't be blank", "Esd is not a number")
      end
      it '配送日の目安（esd）のid:0では登録できない' do
        @item.esd_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Esd must be other than 0")
      end
    end
  end
end