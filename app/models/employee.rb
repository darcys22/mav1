class Employee < ActiveRecord::Base

    def self.import(file)
        preferences = ::MotionlessAgitator::EmployeeAvailability.new
        preferences.read(file)
        preferences.save
    end
end
