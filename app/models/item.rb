class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :shipping_fee
  belongs_to :status
  belongs_to :waiting_date
  # has_one    :buy
  belongs_to :user
  has_one_attached :image

  # ジャンルの選択が「---」の時は保存できないようにする

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  validates :name, :description, :price, :image, presence: true

  validates :category_id, :prefecture_id, :shipping_fee_id, :status_id, :waiting_date_id,
            numericality: { other_than: 0 }
end
