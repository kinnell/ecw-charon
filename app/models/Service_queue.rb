class ServiceQueue < ActiveRecord::Base
  validates :name, presence: true

  has_many :tickets, dependent: :destroy

  def specialties_array
    specialties ? specialties.split(", ") : [""]
  end

  def average_waiting_time
    compound_factor = 10
    total_waiting_time = tickets.not_waiting.inject(0) { |sum, t| sum + t.waiting_time }
    (total_waiting_time + (initial_waiting_time * 60 * compound_factor)) / (tickets.not_waiting.count + compound_factor)
  end


end
