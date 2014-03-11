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
      namestring = ""
      namestring << lastname.capitalize unless lastname.nil?
      namestring << ", " unless lastname.nil?
      namestring << self.firstname.capitalize unless firstname.nil?
      namestring
    end

   [:monstart, :tuestart, :wedstart, :thurstart, :fristart, :satstart, :sunstart, :monfinish, :tuefinish, :wedfinish, :thurfinish, :frifinish, :satfinish, :sunfinish].each do |attr|
     define_method("#{attr}_human") do
       (send(attr) || Date.today).strftime("%l:%M %p")
     end

     define_method("#{attr}_human=") do |date_string|
       self.send "#{attr}=", Chronic.parse(date_string).strftime("%H:%M")
     end
   end

    

    private
      
      def init
        self.desired ||= 40
      end
end
