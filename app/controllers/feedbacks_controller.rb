class FeedbacksController < ApplicationController
  def index
    @order = DeliveryOrder.where(order_id: params[:delivery_order_id]).first!
    json_response(
      collect_feedbacks(@order).map { |feedback|
        {
          ratable_type: feedback.ratable_type,
          rating: feedback.rating,
          comment: feedback.comment
        }
      })
  end

  private

  def collect_feedbacks(order)
    if order.feedback.nil?
      []
    else
      [
        order.feedback, 
        *order.order_items.map { |order_item| order_item.feedback }
      ]
    end
  end
end
