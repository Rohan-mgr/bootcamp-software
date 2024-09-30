class AddForeignKeyToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :order_groups, :customers
    add_foreign_key :order_groups, :customers, on_delete: :nullify
  end
end
