require 'rails_helper'

RSpec.describe 'Feedbacks API', type: :request do
  let!(:order) { create(:delivery_order) }
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
end