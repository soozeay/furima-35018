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

RSpec.describe "Carts", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context 'カートに商品を保存できるとき' do
    it '正しく処理すれば保存できる' do
      # @userでログインする
      sign_in(@user)
      expect(page).to have_no_link('ログイン')
      # トップページから@itemを探す
      expect(page).to have_link(@item.name)
      # リンクをクリックし、商品詳細ページへ遷移する
      click_link @item.name
      # カートに在庫量全て入れる
      select @item.stock, from: 'quantity'
      # LineItemのカウントが一上がることを確認する
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
  end
  context 'カートに保存できない' do
    it 'ログインしていないと保存できない' do
      # トップページに遷移する
      visit root_path
      expect(page).to have_link('ログイン')
      # トップページから@itemを探す
      expect(page).to have_link(@item.name)
      # リンクをクリックし、商品詳細ページへ遷移する
      click_link @item.name
      # このページに、「カートに入れる」ボタンがないことを確認する
      expect(page).to have_no_selector('quantity')
    end
  end
end
