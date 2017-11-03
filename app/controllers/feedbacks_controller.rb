class FeedbacksController < ApplicationController
  before_action :set_order

  def index
    json_response(
      collect_feedbacks(@order).map { |feedback|
        {
          ratable_type: feedback.ratable_type,
          rating: feedback.rating,
          comment: feedback.comment
        }
      })
  end

  def create
    writable_ratables = [
      @order,
      *@order.order_items
    ];
    @order.transaction do
      params[:feedbacks].each { |ratable_params|
        ratable = get_ratable(ratable_params[:ratable_type], ratable_params[:ratable_id])
        if writable_ratables.include? ratable
          ratable.create_feedback!({
            rating: ratable_params[:rating],
            comment: ratable_params[:comment]
          })
        else
          raise ArgumentError.new('Invalid ratable_id or ratable_type')  
        end
      }
    end
    json_response({ status: "OK" }, :created)
    rescue ArgumentError => exception
      json_response({ status: "FAILED", message: exception.message }, :bad_request)
  end

  private

  def set_order
    @order = DeliveryOrder.where(order_id: params[:delivery_order_id]).first!
  end

  def get_ratable(ratable_type, ratable_id)
    if ratable_type == "DeliveryOrder"
      DeliveryOrder.find(ratable_id)
    elsif ratable_type == "OrderItem"
      OrderItem.find(ratable_id)
    else
      nil
    end
  end

  def collect_feedbacks(order)
    if order.feedback.nil?
      []
    else
      [
        order.feedback,
        *order.order_items.map { |order_item| order_item.feedback }
      ].select { |feedback| feedback.present? }
    end
  end
end
