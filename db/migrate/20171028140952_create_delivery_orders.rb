class CreateDeliveryOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_orders do |t|
      t.string :order_id
      t.datetime :serving_datetime

      t.timestamps
    end

    add_index :delivery_orders, :order_id, unique: true
  end
end
