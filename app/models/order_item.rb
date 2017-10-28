class OrderItem < ApplicationRecord
  belongs_to :delivery_order
  belongs_to :meal

  validates_presence_of :delivery_order, :meal, :quantity, :unit_price
end
