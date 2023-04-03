class DeleteTimeslotFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :timeslot, :string
  end
end
