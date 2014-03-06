class DashboardController < ApplicationController
  def index
  end

  def render
      byebug
      availability = ::MotionlessAgitator::EmployeeAvailability.new
      required_hours = ::MotionlessAgitator::WeeklyDemand.new
      ::MotionlessAgitator::Renderer.new(availability, required_hours).render!
  end
end
