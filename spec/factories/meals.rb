FactoryBot.define do
  factory :meal do
    name { Faker::Food.dish }
    byline { Faker::Lorem.sentence }
  end
end
