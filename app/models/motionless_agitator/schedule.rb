module MotionlessAgitator

    class Schedule

        def initialize
            @schedule = {} 
        end

        def add(shifts)
            @schedule.merge!(shifts)
        end

        def return_by_day(day)
            @schedule.select do |element| 
                DAYNAMES[element.value.begin.wday]  == day
            end
        end

        def return_by_date(date)
            @schedule.select do |element|
                element.value.begin.to_date == date
            end 
        end

        def week_start
            @schedule.values.min.to_date
        end

        def by_employee(employee)
            @schedule.inject(0) do |hours, (key, value) |
                hours += key.hours if value = employee.name
            end
        end
    end
end
