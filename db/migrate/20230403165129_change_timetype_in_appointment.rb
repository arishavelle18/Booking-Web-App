class ChangeTimetypeInAppointment < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :check_in
  end

end
