class DeleteColumnIntervalFromSlots < ActiveRecord::Migration[7.0]
  def change
    remove_column :slots, :interval, :integer
  end
end
