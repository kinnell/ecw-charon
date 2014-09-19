class ServiceQueue < ActiveRecord::Base
	validates :name, presence: true

	has_many :tickets

	def waiting_spot_of(ticket) self.tickets.waiting.index(ticket)+1 if ticket.waiting? end

end
