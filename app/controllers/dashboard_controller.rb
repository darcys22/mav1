class DashboardController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth

  def check_auth
    unless user_signed_in?
      redirect_to :controller => :landing_page
    end
  end

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

  def resolve
    @schedule = Schedule.first
    @employees = Employee.all
    @issues = @schedule.observers.where(type: "NoAvailability").first.shifts
    if request.post?
      resolution_shifts = Hash[params[:user_selections].map {|k, v| [Shift.find_by_id(k), v] }]
      @schedule.add(resolution_shifts)
      redirect_to root_url, notice: "Employees imported."
    end
  end

  def short
    @issues = Shift.all.take(5)
    @employees = Employee.all
  end

end
