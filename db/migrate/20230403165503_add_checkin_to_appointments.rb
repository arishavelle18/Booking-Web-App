class AddCheckinToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :check_in, :datetime
  end
end
