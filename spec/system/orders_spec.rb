require 'rails_helper'

def sign_in(user)
  visit root_path
  # トップページにログインページへ遷移するボタンがあることを確認する
  expect(page).to have_link('ログイン')
  # ログインページへ遷移する
  click_link 'ログイン'
  # 正しいユーザー情報を入力する
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  # ログインボタンを押す
  find('input[name="commit"]').click
  # トップページへ遷移することを確認する
  expect(current_path).to eq(root_path)
end

def card_registration(user)
  # マイページに遷移する
  expect(current_path).to eq(root_path)
  expect(page).to have_link('マイページ')
  click_link 'マイページ'
  # クレジットカードを登録するのボタンをクリックする
  expect(page).to have_link('クレジットカードを登録する')
  click_link 'クレジットカードを登録する'
  # フォームに入力する
  fill_in 'number', with: 4242424242424242
  fill_in 'cvc', with: 123
  select '2', from: 'exp_month'
  select '25', from: 'exp_year'
  # ボタンを押して登録を完了させる
  find('input[value="登録する"]').click
  expect(page).to have_content('カード情報')
  visit root_path
end

def add_to_cart(item)
  # 該当の商品をクリックし、商品詳細ページに遷移する
  expect(current_path).to eq(root_path)
  expect(page).to have_link(item.name)
  click_link item.name
  # 商品をカートに追加する
  select @item.stock, from: 'quantity'
  expect{find('input[value="カートに入れる"]').click}.to change { Lineitem.count }.by(1)
  # マイページに遷移する
  expect(page).to have_link('マイページ')
  click_link 'マイページ'
  # マイページから「カートに入れた商品」というリンクを探す
  expect(page).to have_link('カートに入れた商品')
  # クリックするとカートに入れた@itemが存在している
  click_link 'カートに入れた商品'
  expect(page).to have_content(@item.name)
end

RSpec.describe "Orders", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @another_item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    @buy_quantity = @item.stock
    sleep(0.1)
  end

  context '商品購入できるとき' do
    it '正しく情報を入力すれば購入できる' do
      # @userでサインインする
      sign_in(@user)
      # マイページへ遷移し、クレジットカードを登録する
      card_registration(@user)
      # @itemを選択し、カートに商品を追加する
      add_to_cart(@item)
      # カートに入れた商品から、「購入画面に進む」というボタンを探す
      expect(page).to have_link('購入画面に進む')
      # ボタンをクリックして購入画面に遷移する
      click_link '購入画面に進む'
      expect(current_path).to eq(item_orders_path(@item))
      # フォームに情報を入力する
      fill_in 'postal-code', with: @order_address.postal_code
      select '北海道', from: 'prefecture'
      fill_in 'city', with: @order_address.city
      fill_in 'addresses', with: @order_address.house_number
      fill_in 'phone-number', with: @order_address.phone_number
      expect{find('input[value="購入"]').click}.to change { Order.count }.by(1)
    end
  end
  context '購入処理ができないとき' do
    it 'カードを登録しないと購入画面に遷移できない' do
      # @userでサインインする
      sign_in(@user)
      # @itemを選択し、カートに商品を追加する
      add_to_cart(@item)
      # カートに入れた商品から、「購入画面に進む」というボタンを探す
      expect(page).to have_link('購入画面に進む')
      # カード登録の為、マイページに遷移している
      expect(current_path).to eq(user_path(@user))
      # 購入画面に遷移するもマイページに遷移していることを確認する
      visit item_orders_path(@item)
      expect(current_path).to eq(user_path(@user))
    end
    it 'ログインしないと購入画面に遷移できない' do
      # トップページに遷移する
      visit root_path
      # @itemをクリックする
      expect(page).to have_link(@item.name)
      click_link @item.name
      # 購入画面に遷移してもログインページに戻される
      visit item_orders_path(@item)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
