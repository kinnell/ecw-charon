class Subspecialty < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :specialty
  belongs_to :service_queue  
  before_create :set_service_queue

  has_many :tickets, dependent: :destroy

  def set_service_queue
    self.service_queue_id ||= specialty.service_queue.id
  end

  def available_number_of_workers
    number_of_workers - tickets.being_served.count
  end
end  
