FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number:2)}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 4)}
    password_confirmation {password}
    last_name             {'田中'}
    first_name            {'一郎'}
    last_name_kana        {'タナカ'}
    first_name_kana       {'イチロウ'}
    birth_day             {'1990-08-08'}
  end
end