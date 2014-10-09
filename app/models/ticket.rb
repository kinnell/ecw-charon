class Ticket < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue	

  default_scope -> { order(:created_at) }
  scope :waiting, -> { where(started_service_at: nil) }
  scope :being_served, -> { where.not(started_service_at: nil).where(finished_service_at: nil) }
  scope :not_served, -> { where(finished_service_at: nil) }
  scope :served, -> { where.not(finished_service_at: nil) }
  scope :starred, -> { where(starred: true) }
  scope :not_starred, -> { where(starred: false) }
  scope :sort_by_starred, -> { starred + not_starred } 
  scope :sorted, -> { served + being_served + waiting.merge(starred) + waiting.merge(not_starred) }

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
    if started_service_at then (started_service_at - created_at) else (Time.now - created_at) end
  end

  def service_time
    if started_service_at && finished_service_at
      finished_service_at - started_service_at
    elsif started_service_at
      Time.now - started_service_at
    end
  end

  def print_in_minutes(time_in_seconds)
    "#{(time_in_seconds/60).ceil} min"
  end

  def waiting_spot()
    service_queue.tickets.waiting.sort_by_starred.index(self)+1 if waiting?
  end

  def first_in_waiting?()
    waiting_spot == 1
  end

end
