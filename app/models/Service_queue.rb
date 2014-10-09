class ServiceQueue < ActiveRecord::Base
  validates :name, presence: true

  has_many :tickets, dependent: :destroy

  def specialties_array
    specialties ? specialties.split(", ") : [""]
  end


  def total_waiting_time
    tickets.not_waiting.inject(0) { |sum, t| sum + t.waiting_time }
  end

  def average_waiting_time
    tickets.not_waiting.any? ? total_waiting_time / tickets.not_waiting.count : 0
  end

  def average_waiting_time_compounded(compound_factor)
    (total_waiting_time + (initial_waiting_time * 60 * compound_factor)) / (tickets.not_waiting.count + compound_factor)
  end

  def average_service_time
    tickets.served.any? ? tickets.served.inject(0) { |sum, t| sum + t.service_time } / tickets.served.count : 0
  end

end
