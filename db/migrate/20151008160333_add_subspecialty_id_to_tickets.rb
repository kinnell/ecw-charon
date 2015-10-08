class AddSubspecialtyIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :subspecialty_id, :integer
  end
end
