class CreateOrderGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :order_groups do |t|
      t.string :status, null: false, default: "pending"
      t.datetime :started_at
      t.datetime :completed_at
      t.references :customer, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
