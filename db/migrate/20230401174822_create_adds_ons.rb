class CreateAddsOns < ActiveRecord::Migration[7.0]
  def change
    create_table :adds_ons do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
