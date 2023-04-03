class ChangeColumntypeInSlots < ActiveRecord::Migration[7.0]
  def change
    change_column :slots, :start_time, :string
    change_column :slots, :end_time, :string
  end
end
