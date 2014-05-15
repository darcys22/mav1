class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :profile,Hash

  has_many :businesses
  has_many :weeks
  has_many :leaves, :class_name => 'Leave'
  has_many :observers
  has_many :rosterings
  has_many :schedules
  has_many :shifts
  has_many :employees

  before_save :default_values

  def default_values
        self.timezone ||= 'Pacific Time (US & Canada)'
  end

  def profile_employees
    temp = {}
    employees = self.employees.all
    employees.each do |e|
      add_employee(e, temp)
    end
    self.profile = temp
  end

  def add_employee(employee, temp)
    monday = Profiler.arraybuilder(employee.monstart.in_time_zone, employee.monfinish.in_time_zone)
    Profiler.something_to_the_something(monday, :Monday, temp)
    tuesday = Profiler.arraybuilder(employee.tuestart.in_time_zone, employee.tuefinish.in_time_zone)
    Profiler.something_to_the_something(tuesday, :Tuesday, temp)
    wednesday = Profiler.arraybuilder(employee.wedstart.in_time_zone, employee.wedfinish.in_time_zone)
    Profiler.something_to_the_something(wednesday, :Wednesday, temp)
    thursday = Profiler.arraybuilder(employee.thurstart.in_time_zone, employee.thurfinish.in_time_zone)
    Profiler.something_to_the_something(thursday, :Thursday, temp)
    friday = Profiler.arraybuilder(employee.fristart.in_time_zone, employee.frifinish.in_time_zone)
    Profiler.something_to_the_something(friday, :Friday, temp)
    saturday = Profiler.arraybuilder(employee.satstart.in_time_zone, employee.satfinish.in_time_zone)
    Profiler.something_to_the_something(saturday, :Saturday, temp)
    sunday = Profiler.arraybuilder(employee.sunstart.in_time_zone, employee.sunfinish.in_time_zone)
    Profiler.something_to_the_something(sunday, :Sunday, temp)
  end


end
