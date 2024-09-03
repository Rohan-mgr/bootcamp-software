class AddOrganizationIdToAssets < ActiveRecord::Migration[7.2]
  def change
    add_reference :assets, :organization, null: false, foreign_key: true
  end
end
