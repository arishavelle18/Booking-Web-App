class RenameTimeFromSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :interval, :integer
    add_column :slots, :slot_per_timeslot, :integer
    add_column :slots, :end_time, :time
    rename_column :slots, :time, :start_time
  end
end
