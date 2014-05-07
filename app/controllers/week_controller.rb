class WeekController < ApplicationController
  def index(after = DateTime.now)
      #@week = Week.find( :conditions => ['start > ?', after], :order => "start ASC")
      @week = current_user.week.first 
      unless @week.nil?
          @dates = @week.dates
          @shifts = @week.demand
          @overcapacity = @week.overcap?
          @short = current_user.short.all.length
      end
  end

  def import
      if request.post?
          Week.import(params[:file])
          redirect_to week_url, notice: "Shifts imported."
      end
  end
  
  def download
    filename = "#{Rails.root}/downloads/shifts_sheet.csv"
    send_file(filename, :filename => "ShiftsSheet.csv")
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
