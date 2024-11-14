require 'rails_helper'

RSpec.describe BuysAddresses, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user)
    @buy_address = FactoryBot.build(:buys_addresses, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buy_address).to be_valid
      end

      it 'building_nameが空でも保存できること' do
        @buy_address.building_name = ''
        expect(@buy_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_numberが空だと保存できないこと' do
        @buy_address.post_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Post number can't be blank")
      end

      it 'post_numberが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buy_address.post_number = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Post number is invalid. Include hyphen(-)')
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @buy_address.prefecture_id = 0
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @buy_address.city = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと保存できないこと' do
        @buy_address.house_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁未満だと保存できないこと' do
        @buy_address.phone_number = '123456789'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Must be 10 or 11 digits')
      end

      it 'phone_numberが11桁を超えると保存できないこと' do
        @buy_address.phone_number = '123456789012'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Must be 10 or 11 digits')
      end

      it 'phone_numberに半角数字以外が含まれていると保存できないこと' do
        @buy_address.phone_number = '090-1234-5678'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Must be 10 or 11 digits')
      end

      it 'アイテム情報が無ければ購入できない' do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
