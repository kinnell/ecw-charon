class Subspecialty < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :specialty
  belongs_to :service_queue  
  before_create :set_service_queue

  def set_service_queue
    self.service_queue_id ||= specialty.service_queue.id
  end
end  
