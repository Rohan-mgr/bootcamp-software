class AddDeletedAtToDeliveryOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :delivery_orders, :deleted_at, :datetime
    add_index :delivery_orders, :deleted_at
  end
end
