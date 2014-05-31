module MotionlessAgitator
    class DailyPlanner
        attr_reader :daily_schedule

        def initialize(daily_options)
            @daily_options = daily_options
            @daily_schedule = {}
        end

        def plan!
            byebug
            shifts_by_options_count = count_occurance(:Shift)
            shifts_by_options_count = shifts_by_options_count.sort_by { |shift, count| count}
            shifts_by_options_count.each do |shift, count|
                employee = find_least_available_employee(shift)
                add_shift(shift, employee)
            end
            if @daily_options.length > 0
                #Observer.limited_availability_for_day(@daily_options[0][:Shift].start.to_date, @daily_options)
            end
            @daily_schedule
        end

        def find_least_available_employee(shift)
            shift_count = count_occurance(:Employee)
            shift_count = shift_count.sort_by {|employee, count| count}
            shift_count.each do |employee, count|
                return employee if @daily_options.include?({:Shift => shift, :Employee => employee})
            end
            nil
        end

        def add_shift(shift, employee)
            unless check_shift(shift)
                @daily_schedule[shift] = employee
                remove_from_options(shift)
                remove_from_options(employee)
            end
        end
        
        def check_shift(shift)
            @daily_schedule.detect do |element| 
              element.include?(shift)
            end
        end

        def count_occurance(type = nil)

            @daily_options.inject({}) do |count, option|
                if count.include?(option[type])
                    count[option[type]] += 1
                else
                    count[option[type]] = 1
                end
                count
            end
        end

        def remove_from_options(element)
            @daily_options.delete_if do |option| 
                option.has_value?(element)
            end
        end
    end
end


 
