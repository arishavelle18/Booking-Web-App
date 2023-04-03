class AddReferenceToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :slot, null: false, foreign_key: true
  end
end
