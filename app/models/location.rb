class Location < ApplicationRecord
    has_many :services, dependent: :delete_all
    validates :street, :barangay, :city, :province, :postal_code, presence: { message: "can't be blank" }

end
