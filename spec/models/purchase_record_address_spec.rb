require 'rails_helper'

RSpec.describe PurchaseRecordAddress, type: :model do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      sleep 0.2
      @purchase_record_address = FactoryBot.build(:purchase_record_address, user_id: user.id, item_id: item.id)
    end
  describe '購入情報の保存' do
    context '保存できる場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@purchase_record_address).to be_valid
      end
      it '建物番号が空でも保存できる' do
        @purchase_record_address.building_name = nil
        expect(@purchase_record_address).to be_valid
      end
    end
    context '保存できない場合' do
      it 'user_idがなければ保存できない' do
        @purchase_record_address.user_id = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがなければ保存できない' do
        @purchase_record_address.item_id = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @purchase_record_address.token = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では保存できない' do
        @purchase_record_address.postal_code = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがなければ保存できない' do
        @purchase_record_address.postal_code = '12345678'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が7桁なら保存できない' do
        @purchase_record_address.postal_code = '123-456'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Postal code is the wrong length (should be 8 characters)')
      end
      it '都道府県が空では保存できない' do
        @purchase_record_address.delivery_source_id = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Delivery source can't be blank")
      end
      it '都道府県のidが1だと保存できない' do
        @purchase_record_address.delivery_source_id = 1
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Delivery source must be other than 1')
      end
      it '市区町村が空では保存できない' do
        @purchase_record_address.municipality = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では保存できない' do
        @purchase_record_address.house_number = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では保存できない' do
        @purchase_record_address.telephone_number = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号にハイフンがあれば保存できない' do
        @purchase_record_address.telephone_number = '090-1234567'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が英数混合なら保存できない' do
        @purchase_record_address.telephone_number = '090aaaaaaaa'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が12桁以上なら保存できない' do
        @purchase_record_address.telephone_number = '090123456789'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Telephone number is invalid')
      end
    end
  end
end
