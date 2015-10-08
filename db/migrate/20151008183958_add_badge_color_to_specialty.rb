class AddBadgeColorToSpecialty < ActiveRecord::Migration
  def change
    add_column :specialties, :badge_color, :string, default: "#428BCA"
  end
end
