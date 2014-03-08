class Employee < ActiveRecord::Base
  after_initialize :init

    def self.import(file)
        preferences = ::MotionlessAgitator::EmployeeAvailability.new
        preferences.read(file)
        preferences.save
    end

    private
      
      def init
        self.desired ||= 40
      end
end
