module MotionlessAgitator    
    class EmployeePersister
        class << self
            def save(preferences)
                name = FullNameSplitter.split(preferences.name)
                Employee.create do |e|
                    e.firstname = name[0]
                    e.lastname = name[1]
                    e.monstart = preferences.days[:Monday].start
                    e.tuestart = preferences.days[:Tuesday].start
                    e.wedstart = preferences.days[:Wednesday].start
                    e.thurstart = preferences.days[:Thursday].start
                    e.fristart = preferences.days[:Friday].start
                    e.satstart = preferences.days[:Saturday].start
                    e.sunstart = preferences.days[:Sunday].start
                    e.monfinish = preferences.days[:Monday].finish
                    e.tuefinish = preferences.days[:Tuesday].finish
                    e.wedfinish = preferences.days[:Wednesday].finish
                    e.thurfinish = preferences.days[:Thursday].finish
                    e.frifinish = preferences.days[:Friday].finish
                    e.satfinish = preferences.days[:Saturday].finish
                    e.sunfinish = preferences.days[:Sunday].finish
                end
            end

            def load(preferences)
                e = ::MotionlessAgitator::EmployeePreference.new
                e.name = [preferences.firstname, preferences.lastname].join
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
