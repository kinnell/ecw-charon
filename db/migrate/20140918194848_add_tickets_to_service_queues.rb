class AddTicketsToServiceQueues < ActiveRecord::Migration
  def change
	add_column :tickets, :service_queue_id, :integer
  end
end
