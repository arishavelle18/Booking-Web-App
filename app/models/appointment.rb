class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :service
  belongs_to :slot

  after_save :update_status
  
  def update_status
    if self.check_in < Date.current && self.status == "pending"
      self.update(status: "cancel")
    end
  end



  has_many :bookings, dependent: :delete_all
  validates_presence_of :check_in,:check_out
  # validates :status,presence:true
  validates :number_of_pax, presence:true, numericality: { greater_than: 0 }

  validate :check_in_must_not_be_greater_than_check_out
  
  def self.pending
    where(status: "pending")
  end

  def self.check_out
    where(status: "check out")
  end

  def self.cancel
    where(status: "cancel")
  end


  private

  def check_in_must_not_be_greater_than_check_out
    if check_in.present? && check_out.present? && check_in > check_out
      errors.add(:check_in, "must not be greater than check out")
    end
  end
end
