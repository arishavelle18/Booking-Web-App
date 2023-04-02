class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :bookings, dependent: :delete_all
end
