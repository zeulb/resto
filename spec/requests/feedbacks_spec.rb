require 'rails_helper'

RSpec.describe 'Feedbacks API', type: :request do
  let(:order) { create(:delivery_order) }
  let(:order_id) {
    order.update(feedback: create(:feedback))
    5.times do
      OrderItem.create(
        delivery_order: order,
        meal: create(:meal),
        feedback: create(:feedback),
        quantity: 7,
        unit_price: 1000
      )
    end
    order.order_id
  }

  describe 'GET /orders/:id/feedbacks' do
    before { get "/orders/#{order_id}/feedbacks" }

    context 'when the order exists' do
      it 'returns feedbacks' do
        expect(json).not_to be_empty
        expect(json.size).to eq(6)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:order_id) { 'sushi' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DeliveryOrder/)
      end
    end
  end

  describe 'POST /orders/:id/feedbacks' do
    before {
      order_id
      order.update(feedback: nil)
      order.order_items.each { |order_item| order_item.update(feedback: nil) }
      post "/orders/#{order_id}/feedbacks", :params => {
        "feedbacks": [
          {
            "ratable_id": order.id,
            "ratable_type": "DeliveryOrder",
            "rating": 1,
            "comment": "Nice"
          },
          *order.order_items.map { |order_item|
            {
              "ratable_id": order_item.id,
              "ratable_type": "OrderItem",
              "rating": -1,
              "comment": "Bad"
            }
          }
        ]
      }.to_json, :headers => {
        "Content-Type" => "application/json"
      }
      order.reload
    }

    context 'when the order exists' do
      it 'returns status' do
        expect(json).not_to be_empty
        expect(json['status']).to eq("OK")
      end

      it 'stores delivery order feedback' do
        expect(order.feedback).not_to be_nil
        expect(order.feedback.rating).to eq(1)
        expect(order.feedback.comment).to eq("Nice")
      end

      it 'stores order item feedbacks' do
        order.order_items.each { |order_item|
          expect(order_item.feedback).not_to be_nil
          expect(order_item.feedback.rating).to eq(-1)
          expect(order_item.feedback.comment).to eq("Bad")
        }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when using wrong order_id' do
      let(:order_id) { create(:delivery_order).order_id }

      it 'returns status' do
        expect(json).not_to be_empty
        expect(json['status']).to eq("FAILED")
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the order does not exist' do
      let(:order_id) { 'sushi' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DeliveryOrder/)
      end
    end
  end
end