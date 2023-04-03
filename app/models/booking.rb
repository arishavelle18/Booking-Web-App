class Booking < ApplicationRecord
  belongs_to :payment
  belongs_to :service
  belongs_to :appointment
  belongs_to :service
  belongs_to :address
  has_many :add_on_books,dependent: :delete_all
  
 
end
