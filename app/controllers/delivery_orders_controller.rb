class DeliveryOrdersController < ApplicationController
  def index
    @orders = DeliveryOrder.all
    json_response(@orders)
  end
end
