class AddCancelledAtToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :cancelled_at, :datetime, default: nil
  end
end
