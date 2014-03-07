class Week < ActiveRecord::Base
    has_many :businesses
    has_many :shifts, :through => :businesses

    def dates
        days = self.businesses.where(true).order("date ASC")
        days.map { |d| d.date.strftime("%A, %B %e")}
    end

    def demand
        days = self.businesses.where(true).order("date ASC")
        days.inject([]) do |ary, element| 
            ary << element.shifts.where(true).order("start ASC").map do |s|
                "#{s.start.strftime("%l:%M %p")} - #{s.finish.strftime("%l:%M %p")}"
            end
        end
    end

    def render
      byebug
      availability = ::MotionlessAgitator::EmployeeAvailability.new
      required_hours = ::MotionlessAgitator::WeeklyDemand.new
      ::MotionlessAgitator::Renderer.new(availability, required_hours).render!
    end

    def self.import(file)
        shifts = ::MotionlessAgitator::WeeklyDemand.new
        shifts.read(file)
    end
    
end
