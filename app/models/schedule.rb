class Schedule < ActiveRecord::Base
  belongs_to :week
  has_many :rosterings, :dependent => :delete_all
  has_many :employees, -> { uniq }, :through => :rosterings
        
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
end
