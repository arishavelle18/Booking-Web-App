class AddReferenceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :address, null: false, foreign_key: true
  end
end
