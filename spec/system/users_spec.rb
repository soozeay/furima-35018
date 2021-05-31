require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.create(:user)
  end

  context 'ユーザー登録できるとき' do
    it '情報を正しく入力すれば登録できる' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'nickname', with: @user.nickname
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    fill_in 'password-confirmation', with: @user.password_confirmation
    fill_in 'last-name', with: @user.last_name
    fill_in 'first-name', with: @user.first_name
    fill_in 'last-name-kana', with: @user.last_name_kana
    fill_in 'first-name-kana', with: @user.first_name_kana
    select '1930', from: 'user_birth_day_1i'
    select '1', from: 'user_birth_day_2i'
    select '1', from: 'user_birth_day_3i'
    # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
    expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
    # トップページへ遷移したことを確認する
    expect(current_path).to eq(root_path)
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    end
  end
  context '新規登録できないとき' do
    it '情報に不備があると新規登録ができず、新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する（今回は空入力で進めていく）
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      select '--', from: 'user_birth_day_1i'
      select '--', from: 'user_birth_day_2i'
      select '--', from: 'user_birth_day_3i'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
  context '登録済みユーザーでログインができるとき' do
    it '@another_userでログインする' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @another_user.email
      fill_in 'password', with: @another_user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
