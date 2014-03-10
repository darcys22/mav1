class Schedule < ActiveRecord::Base
  belongs_to :week
  has_many :rosterings, :dependent => :delete_all
  has_many :employees, -> { uniq }, :through => :rosterings
  has_many :shifts, :through => :employees
        
  def add(shifts)
    shifts.each {|k,v| shiftadd(v,k)}
  end

  def shiftadd(user, shift)
    u = Employee.find_by_id(user)
    self.employees << u
    self.save
    u.shifts << shift
    u.save
  end

  def get_dates
    allshifts = self.shifts.where(true)
    dates = allshifts.inject([]) do |d, s|
      d << s.start.to_date unless d.include?(s.start.to_date)
      d
    end
    dates.sort
  end

  def weekrange
    a = get_dates
    range << a.first.strftime("%b %d, %Y")
    range << " - "
    range << a.last.strftime("%b %d, %Y")
    range
  end

  def get_employees
    self.employees.where(true)
  end

  def get_shift(employee, shiftdate)
    self.shifts.find_by(:employee => employee, :start => shiftdate.beginning_of_day..shiftdate.end_of_day)
  end

  def format_shift(shift)
    unless shift.nil?
      shift_string << shift.start.strftime("%l:%M %p")
      shift_string << " - "
      shift_string << shift.finish.strftime("%l:%M %p"0
    else
      shift_string = ""
    end
    shift_string
  end

  def employee_shifts(employee)
    week = get_dates
    (week.first..week.last).inject([]) do |array, element|
      array << format_shift(get_shift(employee, element))
      array
    end
  end
end
