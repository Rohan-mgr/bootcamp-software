class ChangeAssetIdInDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    change_column :delivery_orders, :asset_id, :bigint, null: true, default: nil
  end
end
