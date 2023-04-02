class AddServiceReferenceToSlots < ActiveRecord::Migration[7.0]
  def change
    add_reference :slots, :service, null: false, foreign_key: true
  end
end
