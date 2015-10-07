class Specialty < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue
  has_many :subspecialties, dependent: :destroy
end
