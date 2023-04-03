class ChangeColumnstypeInSlots < ActiveRecord::Migration[7.0]
  def change
    # change_column :appointments, :time, :datetime, using: 'start_time::timestamp'
    # change_column :appointments, :date, :datetime
    add_column :appointments, :number_of_pax, :integer
    rename_column :appointments, :time, :check_in
    rename_column :appointments, :date, :check_out
  end
end
