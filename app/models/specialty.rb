class Specialty < ActiveRecord::Base
  validates :name, presence: true
  validates :badge_color, presence: true

  belongs_to :service_queue
  has_many :subspecialties, dependent: :destroy
  has_many :tickets, through: :subspecialties

  accepts_nested_attributes_for :subspecialties, allow_destroy: true

  def available_number_of_workers
    [number_of_nonspecialized_workers - number_of_nonspecialized_workers_working, 0].max
  end

  def number_of_nonspecialized_workers_working
    subspecialties.with_nonspecialized_workers.inject(0){|count, s| count += s.tickets.being_served.count}
  end

  def number_of_nonspecialized_workers
    number_of_workers - number_of_specialized_workers
  end

  def number_of_specialized_workers
    subspecialties.sum(:number_of_workers)
  end

end
