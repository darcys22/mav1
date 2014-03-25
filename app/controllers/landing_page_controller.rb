class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'devise'
  def index
  end
end
