class Category < ApplicationRecord
  belongs_to :admin_user
  has_many :services, dependent: :delete_all
  # field must be prsent
  validates :name,presence:true,length: {maximum:50}
  validates :description,presence:true,length: {maximum:255}
  
end
