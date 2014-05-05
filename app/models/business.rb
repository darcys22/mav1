class Business < ActiveRecord::Base
  belongs_to :week, :user
  has_many :shifts, :dependent => :destroy, :as => :shiftable
end
