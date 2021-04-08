require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'フォーム内の必要情報が全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）は不正な値です")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください",'名字は漢字で入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください",'名前は漢字で入力してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）を入力してください",'名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください",'名前（カナ）は全角カタカナで入力してください')
      end
      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa00'
        @user.password_confirmation = 'aaa00'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'last_nameが漢字・平仮名・カタカナ意外では登録できない' do
        @user.last_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は漢字で入力してください')
      end
      it 'first_nameが漢字・平仮名・カタカナ意外では登録できない' do
        @user.first_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は漢字で入力してください')
      end
      it 'last_nameが漢字・平仮名・カタカナ意外では登録できない' do
        @user.last_name = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は漢字で入力してください')
      end
      it 'first_nameが漢字・平仮名・カタカナ意外では登録できない' do
        @user.first_name = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は漢字で入力してください')
      end
      it 'last_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.last_name_kana = '亞亞亞亞亞'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.first_name_kana = '亞亞亞亞亞'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
      end
      it 'last_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
      end
      it 'last_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.last_name_kana = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.first_name_kana = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
      end
      it 'last_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.last_name_kana = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.first_name_kana = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
      end
      it 'last_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.last_name_kana = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナで入力してください')
      end
      it 'first_name_kanaが全角カタカナ意外では登録できないこと' do
        @user.first_name_kana = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordは英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です', 'パスワード（確認用）は不正な値です')
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です', 'パスワード（確認用）は不正な値です')
      end
      it 'passwordは全角英語では登録できない' do
        @user.password = 'ａａａａ0000'
        @user.password_confirmation = 'ａａａａ0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です', 'パスワード（確認用）は不正な値です')
      end
    end
  end
end
