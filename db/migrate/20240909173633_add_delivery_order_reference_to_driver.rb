class AddDeliveryOrderReferenceToDriver < ActiveRecord::Migration[7.2]
  def change
    add_reference :delivery_orders, :driver, null: true, default: nil, foreign_key: true
  end
end
