require 'rails_helper'

RSpec.describe DeliveryOrder, type: :model do
  it { should have_many(:order_items) }
  it { should have_one(:feedback) }

  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:serving_datetime) }
end
