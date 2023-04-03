class ChangeColumnForAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :check_in, :date
    change_column :appointments, :check_out, :date
  end
end
