class Ticket < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :service_queue	
  belongs_to :subspecialty

  scope :active, -> { where(active: true) }

  scope :waiting, -> { active.where(started_service_at: nil).order("starred DESC, created_at").includes(:service_queue) }
  scope :being_served, -> { active.where.not(started_service_at: nil).where(finished_service_at: nil).order(:started_service_at).includes(:service_queue) }
  scope :served, -> { active.where.not(finished_service_at: nil).order(:finished_service_at).order(:finished_service_at).includes(:service_queue) }

  scope :not_waiting, -> { being_served + served }

  scope :starred, -> { where(starred: true) }
  scope :not_starred, -> { where(starred: false) }

  def name=(s) super s.titleize end

  def waiting?() started_service_at.nil? end
  def being_served?() (started_service_at.present?) && (finished_service_at.nil?) end
  def served?() finished_service_at.present? end

  def color
    if first_in_waiting? then "warning" end
  end

  def first_in_waiting?
    waiting_spot == 1 || estimated_waiting_time == 0
  end

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

  def waiting_spot
    if waiting? && subspecialty.tickets.waiting.any? && subspecialty.tickets.waiting.index(self)
      subspecialty.tickets.waiting.index(self)+1
    else
      0
    end
  end

  def waiting_spot_in_queue
    if waiting? && service_queue.tickets.waiting.any? && service_queue.tickets.waiting.sort_by(&:estimated_waiting_time).index(self)
      service_queue.tickets.waiting.sort_by(&:estimated_waiting_time).index(self)+1
    else
      0
    end
  end

  def estimated_waiting_time
    if waiting? && waiting_spot
      if waiting_spot <= subspecialty.available_number_of_workers
        0
      elsif subspecialty.number_of_workers_with_specialty > 0
        (waiting_spot / (subspecialty.number_of_workers_with_specialty).to_f).floor * service_queue.initial_waiting_time * 60
      else
        waiting_spot * service_queue.initial_waiting_time * 60
      end  
    end
  end

  def estimated_waiting_time_in_minutes
    if estimated_waiting_time > 0
      "about #{(estimated_waiting_time.to_f / 60).floor} minutes"
    else
      "about less than a minute"
    end
  end

end
