require 'rails_helper'

RSpec.describe 'DeliveryOrders API', type: :request do
  let!(:orders) { create_list(:delivery_order, 10) }
  let!(:meals) { create_list(:meal, 5) }
  let(:order_id) {
    order = orders.first
    meals.each { | meal |
      OrderItem.create(
        delivery_order: order,
        meal: meal,
        quantity: 7,
        unit_price: 1000
      )
    }
    order.order_id
  }

  describe 'GET /orders' do
    before { get '/orders' }

    it 'returns orders' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns delivery dates' do
      json.each { | order |
        date = order['delivery_date']
        expect(date).not_to be_empty
        expect {
          DateTime.strptime(date, "%Y-%m-%d")
        }.not_to raise_error
      }
    end

    it 'returns delivery dates' do
      json.each { | order |
        time = order['delivery_time']
        expect(time).not_to be_empty
        expect {
          DateTime.strptime(time, "%H:%M")
        }.not_to raise_error
      }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /orders/:id' do
    before { get "/orders/#{order_id}" }

    context 'when the record exists' do
      it 'returns the order' do
        expect(json).not_to be_empty
        expect(json['order_id']).to eq(order_id)
        expect(json['delivery_date']).not_to be_empty
        expect {
          DateTime.strptime(json['delivery_date'], "%Y-%m-%d")
        }.not_to raise_error
        expect(json['delivery_time']).not_to be_empty
        expect {
          DateTime.strptime(json['delivery_time'], "%H:%M")
        }.not_to raise_error
      end

      it 'returns the order items' do
        order_items = json['order_items']
        expect(order_items).not_to be_empty
        expect(order_items.size).to eq(5)
        order_items.each { | order_item |
          expect(order_item['name']).not_to be_empty
          expect(order_item['quantity']).to eq(7)
          expect(order_item['total_price']).to eq(7000)
        }
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