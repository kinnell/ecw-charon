class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.integer :service_queue_id
      t.string :name, null: false
      t.integer :number_of_workers, default: 0
      t.timestamps
    end
  end
end
