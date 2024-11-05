require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品が出品できる場合' do
    it 'すべての値が正しく入力されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '商品が出品できない場合' do
    it '商品画像がなければ出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名がなければ出品できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明がなければ出品できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'is invalid without a valid category' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 0')
    end

    it 'is invalid without a valid status' do
      @item.status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 0')
    end

    it 'is invalid without a valid shipping fee' do
      @item.shipping_fee_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee must be other than 0')
    end

    it 'is invalid without a valid prefecture' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it 'is invalid without a valid waiting date' do
      @item.waiting_date_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Waiting date must be other than 0')
    end

    it '価格が300円未満だと出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格がなければ出品できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it 'ユーザー情報がなければ出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end

    it '価格が10000000円以上だと出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が半角数値でないと出品できない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
