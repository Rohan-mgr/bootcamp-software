class SetDefaultCustomerIdToNilInOrderGroups < ActiveRecord::Migration[7.2]
   def change
    change_column_null :order_groups, :customer_id, true
    change_column_default :order_groups, :customer_id, nil
  end
end
