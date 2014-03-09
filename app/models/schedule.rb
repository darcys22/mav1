class Schedule < ActiveRecord::Base
  belongs_to :week
  has_many :rosterings
  has_many :employees, :through => :rosterings
end
