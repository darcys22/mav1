class User < ActiveRecord::Base
  serialize :profile,Array
end
