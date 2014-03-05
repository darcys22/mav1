class AddMinutesToShifts < ActiveRecord::Migration
  def change
      add_column :shifts, :minutes, :integer
  end
end
