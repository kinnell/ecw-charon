class AddInitialWaitingTimeToServiceQueue < ActiveRecord::Migration
  def change
    add_column :service_queues, :initial_waiting_time, :integer, default: 5
  end
end
