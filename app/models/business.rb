class Business < ActiveRecord::Base
  belongs_to :week
  has_many :shifts, :dependent => :destroy, :as => :shiftable
end
