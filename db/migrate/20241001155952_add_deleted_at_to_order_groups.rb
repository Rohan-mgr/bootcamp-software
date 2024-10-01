class AddDeletedAtToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :deleted_at, :datetime
    add_index :order_groups, :deleted_at
  end
end
