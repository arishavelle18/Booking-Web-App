class DeleteReferenceToBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bookings, :cart, foreign_key: true
    remove_column :bookings, :status, :string
    remove_column :bookings, :available_date, :date
    remove_column :bookings, :available_time, :time
  end
end
