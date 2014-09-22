class Ticket < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue	

  default_scope -> { order(:created_at) }
  scope :waiting, -> { where(started_service_at: nil) }
  scope :being_served, -> { where.not(started_service_at: nil).where(finished_service_at: nil) }
  scope :served, -> { where.not(finished_service_at: nil) }

  def status
    if finished_service_at
      "Served"
    elsif started_service_at
      "Being Served"
    else
      "Waiting"
    end
  end

  def waiting?() status == "Waiting" end
  def being_served?() status == "Being Served" end
  def served?() status == "Served" end
end
