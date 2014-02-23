class Employee < ActiveRecord::Base

    def self.import(file)
        preferences = EmployeeAvailability.new
        preferences.read(file)
        preferences.save
    end
end
