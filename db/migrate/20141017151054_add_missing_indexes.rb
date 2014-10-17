class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :tickets, :service_queue_id
  end
end
