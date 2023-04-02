class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.time :time
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
