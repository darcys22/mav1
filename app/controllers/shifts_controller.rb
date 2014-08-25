class ShiftsController < ApplicationController
  before_action :set_shift
    
  def update
    respond_to do |format|
      if @leave.update_attributes(shift_params)
        format.html { redirect_to @leave, :notice => 'Day off was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @leave.errors, :status => :unprocessable_entity }
      end
    end

  end

  def show
    @employees = current_user.schedules.first.employees_off(@shift.start)
  end

  def destroy
    @shift.shiftable = @shift.find_business
    @shift.save
    redirect_to dashboard_index_url
  end

  private
  
      def set_shift
        @shift = current_user.shifts.find(params[:id])
      end

      def shift_params
        params.required(:shift).permit(:shiftable_id)
      end

end
