class DeliveryOrder < ApplicationRecord
  has_many :order_item
end
