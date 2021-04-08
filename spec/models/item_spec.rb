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
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名（name）が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明（desc）が空では登録できない' do
        @item.desc = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it '商品価格（price）が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it '商品価格（price）が300円未満では登録できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it '商品価格（price）が9,999,999円より大きければ登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end
      it '商品価格（price）が半角数字意外では登録できない（全角数字）' do
        @item.price = '９９９'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '商品価格（price）が半角数字意外では登録できない（半角英数字の混同）' do
        @item.price = 'aaa11'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '商品価格（price）が半角数字意外では登録できない（半角英字のみ）' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '商品カテゴリ（category_id）が空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください', 'カテゴリーを選択してください')
      end
      it '商品カテゴリ（category_id）のid:0では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it '商品の状態（status_id）が空では登録できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください', '商品の状態を選択してください')
      end
      it '商品の状態（status_id）のid:0では登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it '配送料の負担（shippingfee）が空では登録できない' do
        @item.shippingfee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料を入力してください', '配送料を選択してください')
      end
      it '配送料の負担（shippingfee）のid:0では登録できない' do
        @item.shippingfee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料を選択してください')
      end
      it '発送元（prefecture）が空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください', '発送元の地域を選択してください')
      end
      it '発送元（prefecture）のid:0では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it '配送日の目安（esd）が空では登録できない' do
        @item.esd_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください', '発送までの日数を選択してください')
      end
      it '配送日の目安（esd）のid:0では登録できない' do
        @item.esd_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
    end
  end
end
