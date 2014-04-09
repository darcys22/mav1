class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :set_overcapacity

  around_filter :set_time_zone, :if => :current_user


  def set_time_zone(&block)
    Chronic.time_class = Time.find_zone(current_user.timezone)
    Time.use_zone(current_user.timezone, &block) 
  end


  def set_overcapacity
    @overcapacity = false
  end

end
