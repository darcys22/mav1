class AddResolvedToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :resolved, :boolean
  end
end
