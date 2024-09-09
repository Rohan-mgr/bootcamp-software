class CreateDrivers < ActiveRecord::Migration[7.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :status
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
