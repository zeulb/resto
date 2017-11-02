require 'securerandom'

FactoryBot.define do
  factory :feedback do
    rating { [-1, 1].sample }
    comment { Faker::Lorem.sentence }
  end
end
