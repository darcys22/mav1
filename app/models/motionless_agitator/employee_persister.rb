module MotionlessAgitator    
    class EmployeePersister
        class << self
            def save(preferences)
                name = FullNameSplitter.split(preferences.name)
                Employee.create do |e|
                    e.firstname = name[0]
                    e.lastname = name[1]
                    e.desired = preferences.desired_hours
                    e.monstart = preferences.days[:Monday].start.in_time_zone(Time.zone)
                    e.tuestart = preferences.days[:Tuesday].start.in_time_zone(Time.zone)
                    e.wedstart = preferences.days[:Wednesday].start.in_time_zone(Time.zone)
                    e.thurstart = preferences.days[:Thursday].start.in_time_zone(Time.zone)
                    e.fristart = preferences.days[:Friday].start.in_time_zone(Time.zone)
                    e.satstart = preferences.days[:Saturday].start.in_time_zone(Time.zone)
                    e.sunstart = preferences.days[:Sunday].start.in_time_zone(Time.zone)
                    e.monfinish = preferences.days[:Monday].finish.in_time_zone(Time.zone)
                    e.tuefinish = preferences.days[:Tuesday].finish.in_time_zone(Time.zone)
                    e.wedfinish = preferences.days[:Wednesday].finish.in_time_zone(Time.zone)
                    e.thurfinish = preferences.days[:Thursday].finish.in_time_zone(Time.zone)
                    e.frifinish = preferences.days[:Friday].finish.in_time_zone(Time.zone)
                    e.satfinish = preferences.days[:Saturday].finish.in_time_zone(Time.zone)
                    e.sunfinish = preferences.days[:Sunday].finish.in_time_zone(Time.zone)
                end
            end

            def load(preferences)
                e = ::MotionlessAgitator::EmployeePreference.new
                e.name = preferences.id
                e.desired_hours = preferences.desired
                e.days[:Monday].start = preferences.monstart 
                e.days[:Tuesday].start = preferences.tuestart 
                e.days[:Wednesday].start = preferences.wedstart 
                e.days[:Thursday].start = preferences.thurstart 
                e.days[:Friday].start = preferences.fristart 
                e.days[:Saturday].start = preferences.satstart 
                e.days[:Sunday].start = preferences.sunstart 
                e.days[:Monday].finish = preferences.monfinish 
                e.days[:Tuesday].finish = preferences.tuefinish 
                e.days[:Wednesday].finish = preferences.wedfinish 
                e.days[:Thursday].finish = preferences.thurfinish 
                e.days[:Friday].finish = preferences.frifinish 
                e.days[:Saturday].finish = preferences.satfinish 
                e.days[:Sunday].finish = preferences.sunfinish 
                e
            end
        end
    end
end
