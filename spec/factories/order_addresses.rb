FactoryBot.define do
  factory :order_address do
    token          { 'tok_' + Faker::Lorem.characters(number: 28) }
    postal_code    { Faker::Lorem.characters(number: 3, min_numeric: 3) + '-' + Faker::Lorem.characters(number: 4, min_numeric: 4)}
    prefecture_id  { Faker::Number.between(from: 1, to: 47) }
    city           { Faker::Address.city }
    house_number   { Faker::Address.street_address }
    building_name  { Faker::Address.building_number }
    phone_number   { Faker::Number.number(digits: 11) }
    association :item, factory: :items
    user_id        { @item.user_id }
  end
end