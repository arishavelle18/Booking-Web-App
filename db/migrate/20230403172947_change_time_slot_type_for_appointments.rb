class ChangeTimeSlotTypeForAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :timeslot, :string
  end
end
