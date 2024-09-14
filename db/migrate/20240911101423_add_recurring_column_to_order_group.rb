class AddRecurringColumnToOrderGroup < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :recurring, :jsonb, default: nil
  end
end
