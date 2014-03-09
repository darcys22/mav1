class Business < ActiveRecord::Base
  belongs_to :week
  has_many :shifts, :dependent => :delete_all, :as => :shiftable
end
