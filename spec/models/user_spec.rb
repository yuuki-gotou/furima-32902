require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it '全ての項目を正しく入力すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに@を含めば登録できる' do
        @user.email = 'aaa@aaa'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上なら登録できる' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合なら登録できる' do
        @user.password = 'aaaaa12'
        @user.password_confirmation = 'aaaaa12'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'last_nameが全角(漢字)なら登録できる' do
        @user.last_name = '鈴木'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'last_nameが全角(ひらがな)なら登録できる' do
        @user.last_name = 'すずき'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'last_nameが全角(カタカナ)なら登録できる' do
        @user.last_name = 'スズキ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'first_nameが全角(漢字)なら登録できる' do
        @user.first_name = '一郎'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'first_nameが全角(ひらがな)なら登録できる' do
        @user.first_name = 'いちろう'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'first_nameが全角(カタカナ)なら登録できる' do
        @user.first_name = 'イチロウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'kana_last_nameが全角カタカナなら登録できる' do
        @user.kana_last_name = 'スズキ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'kana_first_nameが全角カタカナなら登録できる' do
        @user.kana_first_name = 'イチロウ'
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailがある場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが５文字以下なら登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力して下さい')
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ａａａａａ１'
        @user.password_confirmation = 'ａａａａａ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力して下さい')
      end
      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password は半角英数字混合で入力して下さい')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'last_nameが半角(カタカナ)だと登録できない' do
        @user.last_name = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'last_nameが半角(英字)だと登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'last_nameが全角(英字)だと登録できない' do
        @user.last_name = 'ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'first_nameが半角(カタカナ)だと登録できない' do
        @user.first_name = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'first_nameが半角(英字)だと登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'first_nameが全角(英字)だと登録できない' do
        @user.first_name = 'ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力して下さい')
      end
      it 'kana_last_nameが空だと登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it 'kana_first_nameが空だと登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'kana_last_nameが半角(カタカナ)だと登録できない' do
        @user.kana_last_name = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_first_nameが半角(カタカナ)だと登録できない' do
        @user.kana_first_name = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_last_nameが半角(英字)だと登録できない' do
        @user.kana_last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_first_nameが半角(英字)だと登録できない' do
        @user.kana_first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_last_nameが全角(英字)だと登録できない' do
        @user.kana_last_name = 'ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_first_nameが全角(英字)だと登録できない' do
        @user.kana_first_name = 'ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_last_nameが全角(漢字)だと登録できない' do
        @user.kana_last_name = '鈴木'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_first_nameが全角(漢字)だと登録できない' do
        @user.kana_first_name = '一郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_last_nameが全角(ひらがな)だと登録できない' do
        @user.kana_last_name = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は全角（カタカナ）で入力して下さい')
      end
      it 'kana_first_nameが全角(ひらがな)だと登録できない' do
        @user.kana_first_name = 'いちろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角（カタカナ）で入力して下さい')
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
