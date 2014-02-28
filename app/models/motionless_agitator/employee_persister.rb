module MotionlessAgitator    
    class EmployeePersister
        class << self
            def save(preferences)
                @preferences = preferences
                name = FullNameSplitter.split(@preferences.name)
                Employee.create do |e|
                    e.firstname = name[0]
                    e.lastname = name[1]
                    e.monstart = @preferences.days[:Monday].start
                    e.tuestart = @preferences.days[:Tuesday].start
                    e.wedstart = @preferences.days[:Wednesday].start
                    e.thurstart = @preferences.days[:Thursday].start
                    e.fristart = @preferences.days[:Friday].start
                    e.satstart = @preferences.days[:Saturday].start
                    e.sunstart = @preferences.days[:Sunday].start
                    e.monfinish = @preferences.days[:Monday].finish
                    e.tuefinish = @preferences.days[:Tuesday].finish
                    e.wedfinish = @preferences.days[:Wednesday].finish
                    e.thurfinish = @preferences.days[:Thursday].finish
                    e.frifinish = @preferences.days[:Friday].finish
                    e.satfinish = @preferences.days[:Saturday].finish
                    e.sunfinish = @preferences.days[:Sunday].finish
                end
            end

            def load
                EmployeePreference.new do
                    name = [@preferences.firstname, @preferences.lastname].join
                    days[:Monday].start = @preferences.monstart 
                    days[:Tuesday].start = @preferences.tuestart 
                    days[:Wednesday].start = @preferences.wedstart 
                    days[:Thursday].start = @preferences.thurstart 
                    days[:Friday].start = @preferences.fristart 
                    days[:Saturday].start = @preferences.satstart 
                    days[:Sunday].start = @preferences.sunstart 
                    days[:Monday].finish = @preferences.monfinish 
                    days[:Tuesday].finish = @preferences.tuefinish 
                    days[:Wednesday].finish = @preferences.wedfinish 
                    days[:Thursday].finish = @preferences.thurfinish 
                    days[:Friday].finish = @preferences.frifinish 
                    days[:Saturday].finish = @preferences.satfinish 
                    days[:Sunday].finish = @preferences.sunfinish 
                end
            end
        end
    end
end
