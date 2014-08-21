class ShiftsController < ApplicationController
  before_action :set_shift
    
  def update
    #@shift = current_user.shifts.find(params[:shift_id])
    #@emp = @shift.shiftable_type == "Employee" ? @shift.shiftable_id : nil
    ##@shift.update_attributes(params[:shift])
  end

  def show
    @employees = current_user.schedules.first.employees_off(@shift)
  end

  private
  
      def set_shift
        @shift = current_user.shifts.find(params[:id])
      end

end
