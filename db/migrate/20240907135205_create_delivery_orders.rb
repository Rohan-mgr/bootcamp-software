class CreateDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :delivery_orders do |t|
      t.datetime :planned_at, null: false
      t.string :status, null: false
      t.datetime :completed_at, null: true
      t.references :customer_branch, null: false, foreign_key: true
      t.references :order_group, null: false, foreign_key: true
      t.references :asset, null: false, foreign_key: true

      t.timestamps
    end
  end
end
