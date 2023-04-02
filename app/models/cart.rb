class Cart < ApplicationRecord
    has_many :appointments, dependent: :delete_all
end
