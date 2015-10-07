class CreateSubspecialties < ActiveRecord::Migration
  def change
    create_table :subspecialties do |t|
      t.integer :specialty_id
      t.integer :service_queue_id
      t.string :name, null: false
      t.integer :number_of_workers, default: 0
      t.timestamps
    end
  end
end
