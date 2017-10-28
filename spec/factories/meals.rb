FactoryBot.define do
  factory :meal do
    name { Faker::Food.dish }
    byline { Faker::Food.ingredient }
  end
end
