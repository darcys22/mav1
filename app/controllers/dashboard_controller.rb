class DashboardController < ApplicationController
  def index
    @has_a_roster = false
    if Week.first.present?
      @schedule = Week.first.schedule
    end
    if @schedule.present?
      @has_a_roster = true
      @week = @schedule.get_dates
      @weekrange = @schedule.getrange
      @employees = @schedule.getemployees
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SchedulePdf.new(@weekrange, @week)
        send_data pdf.render, filename: "Schedule: #{@weekrange}.pdf"
      end
    end
  end

  def delete
    Schedule.delete_all
    redirect_to root_url
  end


end
