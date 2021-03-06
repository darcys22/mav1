module MotionlessAgitator 
    class EmployeePreference < EmployeeWeekBase
        attr_accessor :desired_hours

        def available?(day)
            available = (time_on_date(day.start) >= self.available_start(day)) 
            available &&= (time_on_date(day.finish) <= self.available_finish(day))
            available &&= not_on_leave?(day)
            available
        end 

        def not_on_leave?(day)
          leave = Leave.where(:employee_id => name, :start => day.start..day.finish).blank?
          leave &&= Leave.where(:employee_id => name, :finish => day.start..day.finish).blank?
          leave
        end

        def available_start(date)
            time_on_date(day_from_date(date).start)
        end

        def available_finish(date)
            time_on_date(day_from_date(date).finish)
        end

        private 
            
            def day_from_date(date)
                @days[::Date::DAYNAMES[date.start.wday].to_sym]
            end

            def time_on_date(date) # Wow wtf
                (date.hour * 60 * 60 + date.min * 60)
            end
    end
end
