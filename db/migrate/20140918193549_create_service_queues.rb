class CreateServiceQueues < ActiveRecord::Migration
  def change
    create_table :service_queues do |t|
	t.string  :name, null: false
      t.timestamps
    end
  end
end
