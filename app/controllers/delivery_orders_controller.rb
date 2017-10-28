class DeliveryOrdersController < ApplicationController
  def index
    @orders = DeliveryOrder.all
    json_response(@orders.map { |order|
      {
        order_id: order.order_id,
        delivery_date: order.serving_datetime.to_date,
        delivery_time: order.serving_datetime.strftime("%H:%M")
      }
    })
  end

  def show
    @order = DeliveryOrder.where(order_id: params[:id]).first!
    json_response({
      order_id: @order.order_id,
      delivery_date: @order.serving_datetime.to_date,
      delivery_time: @order.serving_datetime.strftime("%H:%M"),
      order_items: @order.order_items.map { |order_item|
        {
          name: order_item.meal.name,
          quantity: order_item.quantity,
          total_price: order_item.quantity * order_item.unit_price
        }
      }
    })
  end
end
