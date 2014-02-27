module MotionlessAgitator
    class EmployeeWeekBase
        attr_accessor :name, :days

        def initialize
            @days = Hash[
                Monday: Day.new,
                Tuesday: Day.new,
                Wednesday: Day.new,
                Thursday: Day.new,
                Friday: Day.new,
                Saturday: Day.new,
                Sunday: Day.new ]
            
        end
        
        def total_hours 
           @days.inject(0) do |sum, (key, value)|
               sum += value.hours
           end
        end     
    end
end
