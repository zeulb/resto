class DeliveryOrdersController < ApplicationController
  def index
    @orders = DeliveryOrder.all
    json_response(@orders.map { |order| construct(order) })
  end

  def show
    @order = DeliveryOrder.where(order_id: params[:id]).first!
    json_response(construct(@order))
  end

  private

  def construct(order)
    # Round down serving time to nearest 30 minutes
    serving_start_datetime = \
      Time.at((order.serving_datetime.to_f / 30.minutes).floor * 30.minutes).utc
    serving_end_datetime = serving_start_datetime + 30.minutes
    
    {
      order_id: order.order_id,
      ratable_id: order.id,
      delivery_date: serving_start_datetime.to_date,
      delivery_time: serving_start_datetime.strftime("%H:%M") + "-" + serving_end_datetime.strftime("%H:%M"),
      feedback_submitted: !order.feedback.nil?,
      order_items: order.order_items.map { |order_item|
        {
          name: order_item.meal.name,
          ratable_id: order_item.id,
          quantity: order_item.quantity,
          total_price: order_item.quantity * order_item.unit_price
        }
      }
    }
  end
end
