module MotionlessAgitator 
    class EmployeePreference < EmployeeWeekBase
        attr_accessor :desired_hours

        def available?(day)
            (time_on_date(day.start) >= self.available_start(day)) && (time_on_date(day.finish) <= self.available_finish(day))
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
