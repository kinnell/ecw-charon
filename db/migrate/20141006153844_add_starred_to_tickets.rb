class AddStarredToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :starred, :boolean, default: false
  end
end
