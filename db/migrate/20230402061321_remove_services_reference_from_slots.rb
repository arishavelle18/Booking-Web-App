class RemoveServicesReferenceFromSlots < ActiveRecord::Migration[7.0]
  def change
    remove_reference :slots, :services, null: false, foreign_key: true
  end
end
