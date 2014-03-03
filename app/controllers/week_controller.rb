class WeekController < ApplicationController
  def index(after = DateTime.now)
      #@week = Week.find( :conditions => ['start > ?', after], :order => "start ASC")
      @week = Week.first
      @days = @week.day_names
      @dates = @week.dates
      @shifts = @week.demand
  end

  def import
      if request.post?
          Employee.import(params[:file])
          redirect_to root_url, notice: "Employees imported."
      end
  end

  def new
  end

  def delete
  end
end
