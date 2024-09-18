class AddIsSelfUpdatedToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :is_self_updated, :boolean, default: false
  end
end
