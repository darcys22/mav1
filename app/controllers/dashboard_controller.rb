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
    @schedule = User.current_user.schedules.first
    if @schedule.present?
      @no_avail = User.current_user.weeks.first.try(:shifts).try(:length) || 0
      @has_a_roster = true
      @week = @schedule.get_dates
      @weekrange = @schedule.getrange
      @employees = @schedule.getemployees
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
    @sch = current_user.schedules.first
    @sch.week.destroy
    @sch.destroy
    redirect_to root_url
  end

  def resolve
    @schedule = current_user.schedules.first
    @employees = current_user.employees.all
    if @schedule.observers.where(type: "NoAvailability").empty? 
      redirect_to dashboard_index_url 
    else
      @issues = @schedule.observers.where(type: "NoAvailability").first.shifts 
      if request.post?
        resolution_shifts = Hash[params[:user_selections].map {|k, v| [current_user.shifts.find_by_id(k), v] }]
        @schedule.add(resolution_shifts)
        redirect_to root_url, notice: "Employees imported."
      end
    end
  end

  def short
    @issues = current_user.weeks.first.shifts.all
    @employees = current_user.employees.all
  end

  def shift
    @ident = params[:shift_id]
    shift = current_user.shifts.where(id: @ident).first
    schedule = current_user.schedules.first
    @unavailable = schedule.employees_off(shift.start)
  end

  def selected
    expires_now
    schedule = current_user.schedules.first
    @shift = current_user.shifts.find_by_id(params[:shift_id])
    @ident = params[:employee_id]
    schedule.shiftadd(@ident,@shift)
    @shift.resolved = true
    @shift.save
    redirect_to short_dashboard_index_path 
  end

end
