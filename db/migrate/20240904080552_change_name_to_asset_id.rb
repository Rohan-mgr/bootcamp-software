class ChangeNameToAssetId < ActiveRecord::Migration[7.2]
  def change
    rename_column :assets, :name, :asset_id
    add_index :assets, :asset_id, unique: true
  end
end
