class DeliveryOrder < ApplicationRecord
  has_many :order_items
  has_one :feedback, as: :ratable

  validates_presence_of :order_id, :serving_datetime
end
