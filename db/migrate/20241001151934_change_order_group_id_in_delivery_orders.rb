class ChangeOrderGroupIdInDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    # change_column :delivery_orders, :order_group_id, :bigint, null: true, default: nil
    change_column :delivery_orders, :order_group_id, :bigint, null: false
  end

  # def down
  #   change_column :delivery_orders, :order_group_id, :bigint, null: false
  # end
end
