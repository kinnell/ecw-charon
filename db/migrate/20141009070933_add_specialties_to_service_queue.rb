class AddSpecialtiesToServiceQueue < ActiveRecord::Migration
  def change
    add_column :service_queues, :specialties, :string
  end
end
