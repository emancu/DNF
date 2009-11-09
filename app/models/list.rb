class List < ActiveRecord::Base
  # id, name, user
  has_many :tasks, :dependent => :delete_all
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id

end

