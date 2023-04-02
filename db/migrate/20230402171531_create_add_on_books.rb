class CreateAddOnBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :add_on_books do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
