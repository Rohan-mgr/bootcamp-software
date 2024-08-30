class CreateAssets < ActiveRecord::Migration[7.2]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :asset_status
      t.string :asset_category
      # t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
