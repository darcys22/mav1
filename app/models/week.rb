class Week < ActiveRecord::Base
    has_many :businesses, :dependent => :destroy
    has_many :shifts, :through => :businesses
    has_one :schedule
    belongs_to :user

    after_commit :week_check

    def dates
        days = self.businesses.where(true).order("date ASC")
        days.map { |d| d.date.strftime("%A, %B %e")}
    end

    def weekstart
      self.businesses.where(true).order("date ASC").first.date
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
        day = Profiler.arraybuilder(shift.start.in_time_zone, shift.finish.in_time_zone)
        Profiler.something_to_the_something(day, Date::DAYNAMES[shift.start.wday].to_sym, profile)
        profile
      end
    end

    def insufficient_days
      week = profile
      binding.pry
      emp = User.current_user.employees.all.length
      week.inject([]) do |failed, day|
        if day.last.max > emp
          failed << day.first
        end
        failed
      end
    end
     
    def overcap?
      if insufficient_days.length > 0
        return true
      else
        false
      end
    end

    def check_availability
      failed = []
      employee_profile = User.current_user.profile_employees
      profile.each do |day|
        loop do
          c = employee_profile[day.first].zip(day.last).map { |a, b| b - a}

          data = c.each_with_index.chunk { |x, i| x > 0 }.map do |match, pairs| 
              [match, pairs.first[1], pairs.map(&:first)] 
          end

          trues = data.find_all {|i| i[0] && i[1] > 0 }
          byebug
          break unless trues.length > 0

          trues.each do |i|
            start = i[1]/2 - 1
            datestring = start.to_s + " oclock " + day.first.to_s
            overshift = Chronic.parse(datestring, :now => weekstart - 1.day)
            overshift = (Shift.where("start >= ?", overshift) - failed).first
            over = Profiler.arraybuilder(overshift.start, overshift.finish)
            Profiler.addarray(over, day.first, employee_profile)
            failed << overshift
          end
        end
        failed
      end
      failed
      #unless (0...employee_profile[day.first].length).all?{ |i| employee_profile[day.first][i] >= day.last[i] }
    end

    def week_check
      #Overcapacity.delete_all
      #if overcap?
        #Overcapacity.create
      #end

      #check_availability.each do |short|
        #Short.create
      #end
    end

    def find_short_availablility_periods
    end

    def self.renderer
      week = User.current_user.weeks.first
      availability = ::MotionlessAgitator::EmployeeAvailability.new
      required_hours = ::MotionlessAgitator::WeeklyDemand.new(week)
      scheduleid = ::MotionlessAgitator::Renderer.new(availability, required_hours).render!
      User.current_user.schedules.find(scheduleid).update_attributes(:week_id => week.id)
      week.destroy
    end

    def self.import(file)
        shifts = ::MotionlessAgitator::WeeklyDemand.new(User.current_user.weeks.create)
        shifts.read(file)
    end
    
end
