class WeekController < ApplicationController
  def index(after = DateTime.now)
      #@week = Week.find( :conditions => ['start > ?', after], :order => "start ASC")
      @week = Week.first 
      unless @week.nil?
          @dates = @week.dates
          @shifts = @week.demand
      end
  end

  def import
      if request.post?
          Week.import(params[:file])
          redirect_to week_url, notice: "Employees imported."
      end
  end

  def renderer
    Week.renderer
    redirect_to root_url
  end

  def new
  end

  def delete
    Week.destroy_all
    redirect_to week_url
  end
end
