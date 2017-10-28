require 'rails_helper'

RSpec.describe 'DeliveryOrders API', type: :request do
  let!(:orders) { create_list(:delivery_order, 10) }

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
end