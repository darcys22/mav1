class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  
  #before_filter :set_time_zone

  #def set_time_zone
    #Time.zone = current_user.time_zone if current_user
  #end
end
