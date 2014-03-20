class User < ActiveRecord::Base
  serialize :profile,Array

  def profile_employees
    temp = []
    employees = Employee.all
    employees.each do |e|
      add_employee(e, temp)
    end
    self.profile = temp
  end

  def add_employee(employee, temp)
    monday = Profiler.arraybuilder(employee.monstart, employee.monfinish)
    temp[:Monday] = [temp[:Monday], Profiler.dayarray(:Monday, monday)].transpose.map {|x| x.reduce(:+)} #This should go into the profiler class so the return is the temp
    tuesday = Profiler.arraybuilder(employee.tuestart, employee.tuefinish)
    temp << Profiler.dayarray(:Tuesday, tuesday)
    wednesday = Profiler.arraybuilder(employee.wedstart, employee.wedfinish)
    temp << Profiler.dayarray(:Wednesday, wednesday)
    thursday = Profiler.arraybuilder(employee.thurstart, employee.thurfinish)
    temp << Profiler.dayarray(:Thursday, thursday)
    friday = Profiler.arraybuilder(employee.fristart, employee.frifinish)
    temp << Profiler.dayarray(:Friday, friday)
    saturday = Profiler.arraybuilder(employee.satstart, employee.satfinish)
    temp << Profiler.dayarray(:Saturday, saturday)
    sunday = Profiler.arraybuilder(employee.sunstart, employee.sunfinish)
    temp << Profiler.dayarray(:Sunday, sunday)
  end


end
