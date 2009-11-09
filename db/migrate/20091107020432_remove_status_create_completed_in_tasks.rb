class RemoveStatusCreateCompletedInTasks < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :status

    add_column :tasks, :completed, :boolean
  end

  def self.down
    add_column :tasks, :status, :string

    remove_column :tasks, :completed
  end
end
