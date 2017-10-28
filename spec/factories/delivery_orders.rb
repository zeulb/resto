FactoryBot.define do
  factory :delivery_order do
    order_id { Faker::Code.unique.asin }
    serving_datetime { Faker::Time.forward(30, :day) }
  end
end
