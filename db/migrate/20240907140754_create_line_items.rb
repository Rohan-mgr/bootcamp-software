class CreateLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :line_items do |t|
      t.string :name, null: false
      t.float :quantity, null: false
      t.string :units, null: false
      t.references :delivery_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
