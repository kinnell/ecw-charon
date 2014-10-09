class AddRefreshIntervalToServiceQueue < ActiveRecord::Migration
  def change
    add_column :service_queues, :refresh_interval, :integer, required: true, default: 1
  end
end
