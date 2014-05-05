class Rostering < ActiveRecord::Base
  belongs_to :employee
  belongs_to :schedule
  belongs_to :user
end
