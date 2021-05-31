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

def transition_item_path
  expect(page).to have_link('出品する')
  click_link '出品する'
  expect(current_path).to eq(new_item_path)
end

RSpec.describe "Items", type: :system do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.create(:user)
  end

  context '出品できるとき' do
    it '正しく情報を入力すれば出品できる' do
      # トップページに移動し、@userでログインする
      visit root_path
      sign_in(@user)
      # 出品ページに遷移する
      transition_item_path
      # フォームに情報を入力する
      attach_file 'item-image', "#{Rails.root}/public/images/test_image.png"
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.desc
      fill_in 'item-stock', with: @item.stock
      select 'レディース', from: 'item-category'
      select '新品・未使用', from: 'item-sales-status'
      select '着払い（購入者負担）', from: 'item-shipping-fee-status'
      select '北海道', from: 'item-prefecture'
      select '1〜2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど出品した商品が存在することを確認する
      expect(page).to have_content(@item.name)
    end
  end
  context '出品できないとき' do
    it 'ログインしていないと出品のページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規出品ページへのリンクがない
      expect(page).to have_no_content('出品する')
      # 強制的に出品ページに遷移しようとしてもサインインページに遷移している
      visit new_item_path
      expect(current_path).to eq new_user_session_path
    end
    it '情報が不足していると出品できない（Itemのカウントが上がらない）' do
      visit root_path
      sign_in(@user)
      # 出品ページに遷移する
      transition_item_path
      # フォームに情報を入力する
      fill_in 'item-name', with: ''
      fill_in 'item-info', with: ''
      fill_in 'item-stock', with: ''
      select '--', from: 'item-category'
      select '--', from: 'item-sales-status'
      select '--', from: 'item-shipping-fee-status'
      select '--', from: 'item-prefecture'
      select '--', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: ''
      # 送信してもItemモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(0)
      # 同じページにいることを確認する
      expect(current_path).to eq items_path
    end
  end
end

RSpec.describe '編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    sleep(0.1)
  end

  context '商品の編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      # @item1を出品したユーザーでログインする
      sign_in(@item1.user)
      # @item1がトップページに存在することを確認する
      expect(page).to have_content(@item1.name)
      # @item1の詳細ページへ遷移する
      expect(page).to have_link(@item1.name)
      click_link @item1.name
      # 編集するのボタンがあることを確認する
      expect(page).to have_link('商品の編集')
      # 編集ページへ遷移する
      click_link '商品の編集'
      expect(current_path).to eq edit_item_path(@item1)
      # 内容を編集する
      fill_in 'item-name', with: "編集テストです"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{find('input[name="commit"]').click}.to change{ Item.count}.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(item_path(@item1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の商品名が存在することを確認する
      expect(page).to have_content("編集テストです")
    end
  end
  context '編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # @item1を出品したユーザーでログインする
      sign_in(@item1.user)
      # @item2の詳細ページへ移行する
      expect(page).to have_link(@item2.name)
      click_link @item2.name
      # 「編集する」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
      # 編集ページに遷移してもトップページに戻されている
      visit edit_item_path(@item2)
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # @item1をクリックし、詳細ページに遷移する
      expect(page).to have_link(@item1.name)
      click_link @item1.name
      expect(current_path).to eq(item_path(@item1))
      # 編集する」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
      # 編集ページに遷移してもログインページに戻されている
      visit edit_item_path(@item1)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    sleep(0.1)
  end

  context '削除ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の削除ができる' do
      # @item1を出品したユーザーでログインする
      sign_in(@item1.user)
      # トップページに@item1があることを確認する
      expect(page).to have_link(@item1.name)
      # @item1の詳細ページに遷移する
      click_link @item1.name
      # 「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: item_path(@item1)
      # 商品を削除するとレコードの数が1減ることを確認する
      expect{find_link('削除',  href: item_path(@item1)).click}.to change{ Item.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには@item1が存在しないことを確認する
      expect(page).to have_no_content(@item1.name)
    end
  end
  context '削除ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の削除ができない' do
      # @item1を出品したユーザーでログインする
      sign_in(@item1.user)
      # @item２の詳細ページへ遷移する
      expect(page).to have_link(@item2.name)
      click_link @item2.name
      expect(current_path).to eq(item_path(@item2))
      # 「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないと削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # @item1の詳細ページに遷移できない事を確認する
      visit item_path(@item1)
      # 「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end
