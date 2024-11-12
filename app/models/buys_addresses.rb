class BuysAddresses
  include ActiveModel::Model
  attr_accessor :post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number, :item_id, :token, :user_id

  with_options presence: true do
    validates :item_id,
              numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1_000_000,
                              message: 'is invalid' }
    validates :user_id
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    buy = Buy.create(item_id: item_id, user_id: user_id)
    Address.create(buy_id: buy.id, post_number: post_number, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number)
  end
end
