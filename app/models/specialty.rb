class Specialty < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue
  has_many :subspecialties, dependent: :destroy

  accepts_nested_attributes_for :subspecialties, allow_destroy: true
end
