class AddColumnsToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :phone_no, :string
    add_column :customers, :email, :string
    add_column :customers, :zipcode, :integer
    add_column :customers, :address, :string
  end
end
