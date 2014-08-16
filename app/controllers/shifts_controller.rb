class ShiftsController < ApplicationController
  def update
    @shift = current_user.shifts.find(params[:shift_id])
    @emp = @shift.shiftable_type == "Employee" ? @shift.shiftable_id : nil
    #@shift.update_attributes(params[:shift])
  end
end
