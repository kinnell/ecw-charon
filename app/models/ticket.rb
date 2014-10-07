class Ticket < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue	

  default_scope -> { order(:created_at) }
  scope :waiting, -> { where(started_service_at: nil) }
  scope :being_served, -> { where.not(started_service_at: nil).where(finished_service_at: nil) }
  scope :served, -> { where.not(finished_service_at: nil) }
  scope :starred, -> { where(starred: true) }
  scope :not_starred, -> { where(starred: false) }

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

  def waiting_time
    (started_service_at - created_at) if started_service_at
  end

  def service_time
    (finished_service_at - started_service_at) if started_service_at && finished_service_at
  end

  def print_in_minutes(time_in_seconds)
    "#{(time_in_seconds/60).ceil} min"
  end

end
