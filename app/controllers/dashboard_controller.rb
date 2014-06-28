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
    @no_avail = 0 #User.current_user.schedules.first.shifts.length
    @schedule = User.current_user.schedules.first
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
    @schedule = current_user.schedules.first
    @employees = current_user.employees.all
    @issues = @schedule.observers.where(type: "NoAvailability").first.shifts
    if request.post?
      resolution_shifts = Hash[params[:user_selections].map {|k, v| [current_user.shifts.find_by_id(k), v] }]
      @schedule.add(resolution_shifts)
      redirect_to root_url, notice: "Employees imported."
    end
  end

  def short
    @issues = current_user.shifts.all.take(5)
    @employees = current_user.employees.all
  end

  def shift
    @ident = params[:shift_id]
    shift = current_user.shifts.where(id: @ident).first
    available = ::MotionlessAgitator::EmployeeAvailability.new.search_for_available_id(shift)
    @unavailable = current_user.employees.where.not(id: available)
  end

  def selected
    expires_now
    schedule = current_user.schedules.first
    @shift = current_user.shifts.find_by_id(params[:shift_id])
    @ident = params[:employee_id]
    #schedule.shiftadd(@ident,@shift)
    #shift.resolved = true
  end

end
