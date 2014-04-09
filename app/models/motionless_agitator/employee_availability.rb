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

        def read(csv_file) #Have added stuff to here delete
            puts "Time Zone is: "
            puts Time.zone
            CSV.foreach(csv_file.path, :headers => true) do |csv_obj|
                @employees << EmployeePreference.new.tap do |emp|
                    emp.name = csv_obj['name']
                    emp.desired_hours = csv_obj['desired_hours'].to_i
                    emp.days.each do |key, day|
                        day.start = Chronic.parse(csv_obj["#{key.to_s}_start"]).in_time_zone(Time.zone)
                        day.finish = Chronic.parse(csv_obj["#{key.to_s}_finish"], ambiguous_time_range: (day.start.hour + 4)).in_time_zone(Time.zone)
                        puts "What is saved: "
                        puts day.start
                        puts "What is in the csv: "
                        puts csv_obj["#{key.to_s}_start"]
                        puts "What chronic thinks: "
                        puts Chronic.parse(csv_obj["#{key.to_s}_start"])
                        puts Chronic.parse(csv_obj["#{key.to_s}_start"]).in_time_zone(Time.zone)
                    end
                end
            end
        end

        def save #Have added stuff to here delete
            @employees.each do |employee|
                puts "What gets sent to the persister: "
                puts employee.days[:Monday].start
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

