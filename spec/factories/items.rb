FactoryBot.define do
  factory :item do
    name             { Faker::Lorem.sentence }
    desc             { Faker::Lorem.sentence }
    price            { Faker::Number.between(from: 300, to: 300000) }
    stock            { Faker::Number.between(from: 1, to: 20) }
    category_id      { Faker::Number.between(from: 1, to: 10) }
    status_id        { Faker::Number.between(from: 1, to: 6) }
    shippingfee_id   { Faker::Number.between(from: 1, to: 2) }
    prefecture_id    { Faker::Number.between(from: 1, to: 47) }
    esd_id           { Faker::Number.between(from: 1, to: 3) }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test.png')
    end
  end
end
