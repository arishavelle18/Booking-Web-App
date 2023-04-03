class AddTimeslotColumnToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :timeslot, :datetime
  end
end
