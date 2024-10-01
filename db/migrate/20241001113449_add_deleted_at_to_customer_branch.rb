class AddDeletedAtToCustomerBranch < ActiveRecord::Migration[7.2]
  def change
    add_column :customer_branches, :deleted_at, :datetime
    add_index :customer_branches, :deleted_at
  end
end
