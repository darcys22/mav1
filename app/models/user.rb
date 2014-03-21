class User < ActiveRecord::Base
  serialize :profile,Array

  def profile_employees
    temp = {}
    employees = Employee.all
    employees.each do |e|
      add_employee(e, temp)
    end
    self.profile = temp
  end

  def add_employee(employee, temp)
    monday = Profiler.arraybuilder(employee.monstart, employee.monfinish)
    Profiler.something_to_the_something(monday, :Monday, temp)
    tuesday = Profiler.arraybuilder(employee.tuestart, employee.tuefinish)
    Profiler.something_to_the_something(tuesday, :Tuesday, temp)
    wednesday = Profiler.arraybuilder(employee.wedstart, employee.wedfinish)
    Profiler.something_to_the_something(wednesday, :Wednesday, temp)
    thursday = Profiler.arraybuilder(employee.thurstart, employee.thurfinish)
    Profiler.something_to_the_something(thursday, :Thursday, temp)
    friday = Profiler.arraybuilder(employee.fristart, employee.frifinish)
    Profiler.something_to_the_something(friday, :Friday, temp)
    saturday = Profiler.arraybuilder(employee.satstart, employee.satfinish)
    Profiler.something_to_the_something(saturday, :Saturday, temp)
    sunday = Profiler.arraybuilder(employee.sunstart, employee.sunfinish)
    Profiler.something_to_the_something(sunday, :Sunday, temp)
  end


end
