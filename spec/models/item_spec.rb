require 'rails_helper'

RSpec.describe Item, type: :model do
  
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができる' do
      it '全ての項目がきちんと入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが空では出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it 'condition_idが空では出品できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition is not a number")
      end
      it 'delivery_fee_idが空では出品できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank", "Delivery fee is not a number")
      end
      it 'delivery_source_idが空では出品できない' do
        @item.delivery_source_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery source can't be blank", "Delivery source is not a number")
      end
      it 'day_to_ship_idが空では出品できない' do
        @item.day_to_ship_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship can't be blank", "Day to ship is not a number")
      end
      it 'それぞれのidで1が選択されると出品できない' do
        @item.category_id = '1'
        @item.condition_id = '1'
        @item.delivery_fee_id = '1'
        @item.delivery_source_id = '1'
        @item.day_to_ship_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1", "Condition must be other than 1", "Delivery fee must be other than 1", "Delivery source must be other than 1", "Day to ship must be other than 1")
      end
      it 'priceが空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字以外では出品できない' do
        @item.price = '１５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが299以下なら登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 300")
      end
      it 'priceが10000000以上なら登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 9999999")
      end
    end
  end


end