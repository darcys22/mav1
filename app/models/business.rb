class Business < ActiveRecord::Base
  belongs_to :week
  belongs_to :user
  has_many :shifts, :dependent => :destroy, :as => :shiftable
end
