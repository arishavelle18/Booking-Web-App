class Cart < ApplicationRecord
    belongs_to:user
    has_many :appointments, dependent: :delete_all
end
