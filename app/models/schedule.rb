class Schedule < ActiveRecord::Base
  belongs_to :week, :dependent => :destroy
  belongs_to :user
  has_many :rosterings, :dependent => :destroy
  has_many :employees, -> { uniq }, :through => :rosterings
  has_many :shifts, :dependent => :destroy
  has_many :observers, :dependent => :destroy
        
  def add(shifts)
    shifts.each {|k,v| shiftadd(v,k)}
  end

  def shiftadd(user, shift)
      u = User.current_user.employees.find_by_id(user) 
      shift.schedule = self
      shift.save
      if u.nil? 
        shift.ignore = true
        shift.save
      else
        saver(u, shift) 
      end
  end

  def saver(user, shift)
    self.employees << user
    self.save
    user.shifts << shift
    user.save
  end


  def get_dates
    allshifts = self.shifts.where(true)
    dates = allshifts.inject([]) do |d, s|
      d << s.start.to_date unless d.include?(s.start.to_date)
      d
    end
    dates.sort
  end

  def getrange
    da = get_dates
    [da.first, da.last].map { |date| date.strftime("%b %d, %Y")}.join(" - ")
  end

  def getemployees
    self.employees.where(true)
  end

  def employees_off(day)
    getemployees.select{ |emp| !emp.working?(day)}
  end

  def get_shift(employee, shiftdate)
    employee.shifts.find_by(:start => shiftdate.beginning_of_day..shiftdate.end_of_day)
  end

  def format_shift(shift)
    unless shift.nil?
      shift_string = ""
      shift_string << shift.start.strftime("%l:%M %p")
      shift_string << " - "
      shift_string << shift.finish.strftime("%l:%M %p")
    end
    shift_string
  end

  def emp_shifts(employee)
    week = get_dates
    (week.first..week.last).inject([]) do |array, element|
      x = get_shift(employee, element)
      array << format_shift(x)
      array[-1] << "*" if (!x.nil? && x.resolved)
      array
    end
  end

  def no_avail(shift)
    a = self.observers.where(:type => "NoAvailability").first_or_create
    a.shifts << shift
  end

  def short(shift)
    a = self.shorts.where(true).first_or_create
    a.shifts << shift
  end

  def no_availability_errors
    observer = self.observers.where(:type => "NoAvailability").first
    unless observer.nil?
      observer.shifts.length || 0
    else
      0
    end
  end
end
