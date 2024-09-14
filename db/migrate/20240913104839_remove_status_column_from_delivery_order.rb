class RemoveStatusColumnFromDeliveryOrder < ActiveRecord::Migration[7.2]
  def change
    remove_column :delivery_orders, :status
  end
end
