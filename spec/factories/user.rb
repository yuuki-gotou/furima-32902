FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 6)
    password_confirmation { password }
    last_name             { '鈴木' }
    first_name            { '一郎' }
    kana_last_name        { 'スズキ' }
    kana_first_name       { 'イチロウ' }
    birthday              { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
  end
end
