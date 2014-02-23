class EmployeeSaver
    require 'full_name_splitter'

    def initialize(preferences)
        @preferences = preferences
    end

    def call
        split = FullNameSplitter.split(@preferences.name)
        Employee.new do
            firstname = split.first_name
            lastname = split.last_name
            monstart = @preferences.days[:Monday].start
            tuestart = @preferences.days[:Monday].start
            wedstart = @preferences.days[:Monday].start
            thurstart = @preferences.days[:Monday].start
            fristart = @preferences.days[:Monday].start
            satstart = @preferences.days[:Monday].start
            sunstart = @preferences.days[:Monday].start
            mon = @preferences.days[:Monday].start
            monstart = @preferences.days[:Monday].start
            monstart = @preferences.days[:Monday].start
            monstart = @preferences.days[:Monday].start
            monstart = @preferences.days[:Monday].start
            monstart = @preferences.days[:Monday].start

            
    end
end


