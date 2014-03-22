class Week < ActiveRecord::Base
    has_many :businesses, :dependent => :destroy
    has_many :shifts, :through => :businesses
    has_one :schedule

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

    def profile
      shifts = self.shifts.where(true)
      shifts.inject({}) do |profile, shift|
        day = Profiler.arraybuilder(shift.start, shift.finish)
        Profiler.something_to_the_something(day, Date::DAYNAMES[shift.start.wday].to_sym, profile)
        profile
      end
    end

    def check_sufficient_employees
      max = self.profile.map(&:values).flatten.max
      max <= Employee.all.length
    end

    def check_availability
      profile.each do |key, value|
        blah blah check SO
      end
    end

    def self.renderer
      week = Week.first
      availability = ::MotionlessAgitator::EmployeeAvailability.new
      required_hours = ::MotionlessAgitator::WeeklyDemand.new(week)
      scheduleid = ::MotionlessAgitator::Renderer.new(availability, required_hours).render!
      Schedule.find(scheduleid).update_attributes(:week_id => week.id)
      week.destroy
    end

    def self.import(file)
        shifts = ::MotionlessAgitator::WeeklyDemand.new
        shifts.read(file)
    end
    
end
