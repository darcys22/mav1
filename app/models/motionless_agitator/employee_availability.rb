module MotionlessAgitator
    class EmployeeAvailability
        require 'csv'
        require 'chronic'

        IMPORTANT = Chronic.parse("22nd November 1990")
        
        attr_accessor :employees

        def initialize()
            @employees = []
            load_employees
        end

        def search_for_available(day)
          @employees.select do |employee|
            employee.available?(day)
          end
        end

        def search_for_available_id(day)
          search_for_available(day).map(&:name)
        end

        def read(csv_file)
            CSV.foreach(csv_file.path, :headers => true) do |csv_obj|
                @employees << EmployeePreference.new.tap do |emp|
                    emp.name = csv_obj['name']
                    emp.desired_hours = csv_obj['desired_hours'].to_i
                    emp.days.each do |key, day|
                        day.start = Chronic.parse(csv_obj["#{key.to_s}_start"]).in_time_zone(Time.zone)
                        day.finish = Chronic.parse(csv_obj["#{key.to_s}_finish"], ambiguous_time_range: (day.start.hour + 4)).in_time_zone(Time.zone)
                    end
                end
            end
        end

        def save 
            @employees.each do |employee|
                EmployeePersister.save(employee)
            end
        end

        def load_employees
            pref = Employee.all
            pref.each do |emp|
                @employees << EmployeePersister.load(emp)
            end
        end

        def number_of_employees
            @employees.length
        end

        def employees_by_least_available
            @employees.sort { |x, y| x.total_hours <=> y.total_hours }
        end

        def employees_by_most_available
            @employees.sort { |x, y| y.total_hours <=> x.total_hours }
        end
    end
end

