module MotionlessAgitator
    class EmployeeWeekBase
        attr_accessor :name, :days

        def initialize
            @days = Hash[
                Monday: ::Cal::Day.new,
                Tuesday: ::Cal::Day.new,
                Wednesday: ::Cal::Day.new,
                Thursday: ::Cal::Day.new,
                Friday: ::Cal::Day.new,
                Saturday: ::Cal::Day.new,
                Sunday: ::Cal::Day.new ]
            
        end
        
        def total_hours 
           @days.inject(0) do |sum, (key, value)|
               sum += value.hours
           end
        end     
    end
end
