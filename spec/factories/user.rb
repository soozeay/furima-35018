FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'aaa000'}
    password_confirmation {password}
    last_name             {'田中'}
    first_name            {'一郎'}
    last_name_kana        {'タナカ'}
    first_name_kana       {'イチロウ'}
    birth_day             {'1990-08-08'}
  end
end