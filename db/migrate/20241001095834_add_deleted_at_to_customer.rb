class AddDeletedAtToCustomer < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :deleted_at, :datetime
    add_index :customers, :deleted_at
  end
end
