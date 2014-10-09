class AddRemovalReasonToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :removal_reason, :string
  end
end
