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

  def name=(s)
    super s.titleize
  end

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

  def color
    if first_in_waiting? then "warning"
    elsif being_served? then "success"
    elsif served? then "active" end
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

  def print_in_minutes(time_in_seconds)
    "#{(time_in_seconds/60).ceil} min"
  end

  def waiting_spot
    subspecialty.tickets.waiting.index(self)+1 if waiting?
    # if waiting?
    #   if subspecialty.available_number_of_workers > subspecialty.tickets.waiting.index(self)
    #     1
    #   else
    #     subspecialty.tickets.waiting.index(self) - subspecialty.available_number_of_workers + 2
    #   end
    # end
  end

  def waiting_spot_in_queue
    service_queue.tickets.waiting.sort_by(&:estimated_waiting_time).index(self)+1 if waiting?
  end

  def first_in_waiting?
    waiting_spot == 1 || estimated_waiting_time == 0
  end

  def estimated_waiting_time
    if waiting?
      waiting_spot_in_subspecialty = subspecialty.tickets.waiting.index(self)+1
      if waiting_spot_in_subspecialty <= subspecialty.available_number_of_workers
        0
      elsif subspecialty.number_of_workers > 0
        (waiting_spot_in_subspecialty / subspecialty.number_of_workers.to_f).ceil * service_queue.average_waiting_time_compounded(10)
      else
        waiting_spot_in_subspecialty * service_queue.average_waiting_time_compounded(10)
      end
    end
      # max_waiting_time = 30
      # wait_according_to_time_waited = waiting_time > max_waiting_time*60 ? 1 : (max_waiting_time*60 - waiting_time)
      # wait_according_to_waiting_spot = service_queue.average_waiting_time_compounded(10) * (waiting_spot - 1)
      # wait_according_to_waiting_spot
      # [wait_according_to_time_waited, wait_according_to_waiting_spot].min
  end

end
