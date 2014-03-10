class DashboardController < ApplicationController
  def index
    @schedule = Week.first.schedule
    @week = @schedule.get_dates
    @weekrange = @schedule.getrange
    @employees = @schedule.getemployees
  end

end
