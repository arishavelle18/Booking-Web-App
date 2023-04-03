class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :service
  belongs_to :slot

  has_many :bookings, dependent: :delete_all
  validates_presence_of :check_in,:check_out
  # validates :status,presence:true

  validate :check_in_must_not_be_greater_than_check_out

  private

  def check_in_must_not_be_greater_than_check_out
    if check_in.present? && check_out.present? && check_in > check_out
      errors.add(:check_in, "must not be greater than check out")
    end
  end
end
