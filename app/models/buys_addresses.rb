class BuysAddresses
  include ActiveModel::Model
  attr_accessor :post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :item_id, :token, :user_id

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :token
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Must be 10 or 11 digits' }
  end

  def save
    buy = Buy.create(item_id: item_id, user_id: user_id)
    Address.create(buy_id: buy.id, post_number: post_number, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number)
  end
end
