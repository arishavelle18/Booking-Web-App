class RemoveServicesReferenceFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bookings, :services, null: false, foreign_key: true
  end
end
