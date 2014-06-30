module MotionlessAgitator
    
    class Renderer

        def initialize(preferences, demand) #demand is Weekly_demand & preferences is employee_availability
            @demand, @preferences = demand, preferences
            @processed = false
            @schedule = User.current_user.schedules.create
        end

        def render!
            @preferences.employees_by_least_available
            walk_the_rooster
            @processed = true
            @schedule.id
        end

        private
            
            def walk_the_rooster
                ideal = calculate_ideal
                day_order = @demand.sort_by_busiest
                day_order.each do |day|
                    shifts_for_day = @demand.shifts_by_day(day)
                    list = all_availability_for_shifts(shifts_for_day)
                    daily_roster = DailyPlanner.new(list).plan!
                    @schedule.add(daily_roster)
                end
            end

            def all_availability_for_shifts(shifts)
                shifts.inject([]) do |availability, shift|
                    daily_possibles = @preferences.search_for_available(shift)
                    daily_possibles.each { |employee| availability.push({:Shift => shift, :Employee => employee.name})}            
                    availability
                end
            end
                    
            def min_dev(dev_list)
                dev_list.min_by{|k,v|v}[0]
            end

            #def search_for_available(day)  #Move into the @preferences.... This method is gross
                #possibles = @preferences.employees.select do |employee|
                    #employee.available?(day)
                #end
                #if possibles.length < 1
                    #@schedule.no_avail(day)
                #end
                #possibles
            #end

            def deviation(possibles, employee_ideals, day)
                possibles.inject({}) do |deviation, employee| 
                    deviation[employee] = (@schedule.by_employee(employee) + day.hours) - employee_ideals[employee]
                    deviation
                end
            end


            def calculate_ideal
                week_hourly_demand = @demand.week_hours
                @preferences.employees_by_least_available.each_with_index.inject({}) do |ideal, (employee, count)|
                    average = week_hourly_demand / (@preferences.number_of_employees - count)
                    if average > employee.desired_hours
                        ideal[employee] = employee.desired_hours
                        week_hourly_demand -= employee.desired_hours
                    else
                        ideal[employee] = average
                        week_hourly_demand -= average
                    end
                    ideal
                end
            end
    end
end


#Go through infractions and make a hash of the deviations from ideal
    #if deviations > 1 standard deviation or the deviations check = something to ensure against infinite loop
        #walk through the shifts of the largest deviation
        #walk shift through available employees (Sorted by deviation from ideal)
        #give to min devation guy

