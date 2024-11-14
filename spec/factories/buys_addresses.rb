FactoryBot.define do
  factory :buys_addresses do
    post_number { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '12345678901' }
  end
end
