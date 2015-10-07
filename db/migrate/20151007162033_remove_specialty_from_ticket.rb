class RemoveSpecialtyFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :specialty, :string
  end
end
