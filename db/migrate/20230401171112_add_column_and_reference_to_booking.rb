class AddColumnAndReferenceToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :status, :string
    add_column :bookings, :available_date, :date
    add_column :bookings, :available_time, :time
    add_reference :bookings, :services, null: false, foreign_key: true
  end
end
