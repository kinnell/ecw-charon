class AddNoteToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :note, :text
  end
end
