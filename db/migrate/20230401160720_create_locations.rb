class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :street
      t.string :barangay
      t.string :city
      t.string :province
      t.integer :postal_code

      t.timestamps
    end
  end
end
