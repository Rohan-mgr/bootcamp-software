class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_category
      t.string :product_status
      t.string :product_unit

      t.timestamps
    end
  end
end
