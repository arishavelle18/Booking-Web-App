class Booking < ApplicationRecord
  belongs_to :payment, dependent: :destroy
  belongs_to :service
  belongs_to :appointment
  belongs_to :service
  belongs_to :address
  has_many :add_on_books,dependent: :delete_all
  accepts_nested_attributes_for :payment

end
