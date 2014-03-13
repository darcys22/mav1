class Observe < ActiveRecord::Base
  belongs_to :schedule
  has_many :shifts, :as => :shiftable
end
