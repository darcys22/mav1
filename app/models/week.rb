class Week < ActiveRecord::Base
    has_many :businesses, :dependent => :delete_all
    has_many :shifts, :through => :businesses
    has_one :schedule, :dependent => :destroy

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

    def self.renderer
      week = Week.first
      availability = ::MotionlessAgitator::EmployeeAvailability.new
      required_hours = ::MotionlessAgitator::WeeklyDemand.new(week)
      self.schedule = ::MotionlessAgitator::Renderer.new(availability, required_hours).render!
      self.save
    end

    def self.import(file)
        shifts = ::MotionlessAgitator::WeeklyDemand.new
        shifts.read(file)
    end
    
end
