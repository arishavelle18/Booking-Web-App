class Address < ApplicationRecord
  belongs_to :user
  has_one :booking
  validates :street, :barangay, :city, :province, :postal_code, presence: { message: "can't be blank" }

end
