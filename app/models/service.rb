class Service < ApplicationRecord
  belongs_to :admin_user
  belongs_to :category
  belongs_to :location
  has_one :appointment
  has_many :slots, dependent: :delete_all
  has_many :adds_ons, dependent: :delete_all

  def generate_time_slots(service)
    slots = []
    service.slots.each do |slot|
      timeslots = Slot.generate_timeslots(slot.start_time, slot.end_time, slot.interval)
      slots.concat(timeslots.map { |time| ["Time: #{time.strftime("%I:%M %p")} (#{slot.date})".html_safe, slot.id] })
    end
    slots
  end

end
