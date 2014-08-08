class AddScheduleIndexToShifts < ActiveRecord::Migration
  def change
    add_reference :shifts, :schedule, index: true
  end
end
