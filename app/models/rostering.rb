class Rostering < ActiveRecord::Base
  belongs_to :employee
  belongs_to :schedule
end
