class Observer < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :user
  has_many :shifts, :as => :shiftable
end
