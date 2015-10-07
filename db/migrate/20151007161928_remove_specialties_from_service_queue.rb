class RemoveSpecialtiesFromServiceQueue < ActiveRecord::Migration
  def change
    remove_column :service_queues, :specialties, :string
  end
end
