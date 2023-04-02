class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :barangay
      t.string :city
      t.string :province
      t.integer :postal_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
