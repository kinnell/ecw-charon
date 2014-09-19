class Ticket < ActiveRecord::Base
	validates :name, presence: true
	
	belongs_to :service_queue	

	
	default_scope -> { order(:created_at) }
	scope :waiting, -> { where(started_service_at: nil) }
	scope :being_served, -> { where.not(started_service_at: nil).where(finished_service_at: nil) }
	scope :served, -> { where.not(finished_service_at: nil) }


	def status
		if self.finished_service_at
			"Served"
		elsif self.started_service_at
			"Being Served"
		else
			"Waiting"
		end
	end

	def waiting?() self.status == "Waiting" end
	def being_served?() self.status == "Being Served" end
	def served?() self.status == "Served" end
end
