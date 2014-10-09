class AddSpecialtyToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :specialty, :string
  end
end
