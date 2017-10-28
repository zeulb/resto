FactoryBot.define do
  factory :delivery_order do
    order_id { (('A'..'Z').to_a).sample + ((1..1000).to_a).sample }
    serving_datetime { Faker::Time.forward(30, :day) }
  end
end
