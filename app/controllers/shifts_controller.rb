class ShiftsController < ApplicationController
  def index
      @shifts = current_user.shifts.all
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @shift = current_user.shifts.find(params[:shift_id])
    @emp = @shift.shiftable_type == "Employee" ? @shift.shiftable_id : nil
  end

  def update
    @shift = current_user.shifts.find(params[:shift_id])
    @shift.update_attributes(params[:shift])
  end

  def destroy
  end
end
