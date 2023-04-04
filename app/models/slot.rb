class Slot < ApplicationRecord
  belongs_to :service
  has_many :appointments

  validates :start_time,presence: true
  validates :end_time,presence:true

  validates :slot_per_timeslot,presence:true
  validates :date, presence: true

  # def self.generate_timeslots(start_time, end_time,interval)
  #   timeslots = []
  #   current_time = start_time

  #   while current_time < end_time
  #     timeslots << current_time
  #     current_time += interval.minutes
  #   end

  #   timeslots
  # end
end
