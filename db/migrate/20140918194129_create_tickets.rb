class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
	t.string :name, null: false
	t.datetime :started_service_at
	t.datetime :finished_service_at
  	t.timestamps
    end
  end
end
