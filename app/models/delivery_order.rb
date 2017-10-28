class DeliveryOrder < ApplicationRecord
  has_many :order_items

  validates_presence_of :order_id, :serving_datetime
end
