class DashboardController < ApplicationController
  def index
    @has_a_roster = false
    @no_avail = 0
    @schedule = Schedule.first
    if @schedule.present?
      @has_a_roster = true
      @week = @schedule.get_dates
      @weekrange = @schedule.getrange
      @employees = @schedule.getemployees
      @no_avail = @schedule.no_availability_errors 
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SchedulePdf.new(@schedule)
        send_data pdf.render, filename: "Schedule: #{@weekrange}.pdf"
      end
    end
  end

  def delete
    Schedule.delete_all
    redirect_to root_url
  end


end
