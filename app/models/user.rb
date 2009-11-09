class User < ActiveRecord::Base
  validates_uniqueness_of :login
  has_many :lists

  acts_as_authentic

end
