class Task < ActiveRecord::Base
  # Task id, title, completed, list_id
  belongs_to :list
  validates_presence_of :title
  before_create :set_status

private
  def set_status
    self.completed = false
    true
  end

end
