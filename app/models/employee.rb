class Employee < ActiveRecord::Base
  has_many :shifts, :as => :shiftable
  has_many :rosterings
  has_many :schedules, -> { uniq }, :through => :rosterings
  after_initialize :init

    def self.import(file)
        preferences = ::MotionlessAgitator::EmployeeAvailability.new
        preferences.read(file)
        preferences.save
    end

    def format_name
      namestring << self.lastname.capitalize
      namestring << ", "
      namestring << self.firstname.capitalize
      namestring
    end

    private
      
      def init
        self.desired ||= 40
      end
end
