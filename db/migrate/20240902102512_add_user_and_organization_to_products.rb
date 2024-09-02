class AddUserAndOrganizationToProducts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :user, null: false, foreign_key: true
    add_reference :products, :organization, null: false, foreign_key: true
  end
end
