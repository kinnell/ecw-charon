class Subspecialty < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :specialty
  belongs_to :service_queue  
end  
