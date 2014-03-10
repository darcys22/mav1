class DashboardController < ApplicationController
  def index
    @schedule = Week.first.schedule
    if @schedule.present?
      @has_a_roster = true
      @week = @schedule.get_dates
      @weekrange = @schedule.getrange
      @employees = @schedule.getemployees
    else
      @has_a_roster = false
    end
  end

end
