class Employee < ActiveRecord::Base
  has_many :shifts, :as => :shiftable
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
