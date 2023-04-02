class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.time :time
      t.date :date
      t.references :services, null: false, foreign_key: true

      t.timestamps
    end
  end
end
