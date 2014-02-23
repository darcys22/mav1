class EmployeePersister
    require 'full_name_splitter'

    def initialize(preferences)
        @preferences = preferences
    end

    def save
        split = FullNameSplitter.split(@preferences.name)
        Employee.new do
            firstname = split.first_name
            lastname = split.last_name
            monstart = @preferences.days[:Monday].start
            tuestart = @preferences.days[:Tuesday].start
            wedstart = @preferences.days[:Wednesday].start
            thurstart = @preferences.days[:Thursday].start
            fristart = @preferences.days[:Friday].start
            satstart = @preferences.days[:Saturday].start
            sunstart = @preferences.days[:Sunday].start
            monfinish = @preferences.days[:Monday].finish
            tuefinish = @preferences.days[:Tuesday].finish
            wedfinish = @preferences.days[:Wednesday].finish
            thurfinish = @preferences.days[:Thursday].finish
            frifinish = @preferences.days[:Friday].finish
            satfinish = @preferences.days[:Saturday].finish
            sunfinish = @preferences.days[:Sunday].finish
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


