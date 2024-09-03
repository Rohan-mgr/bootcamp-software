class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
