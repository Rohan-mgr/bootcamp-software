class MakeDriverNullableOnDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    change_column_null :delivery_orders, :driver_id, true
  end
end
