require 'sequel'

class TasksRepository
  attr_accessor :db

  def initialize
    @db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_repository_test')
  end

  def create_table
    @db.create_table :task_table do
      primary_key :id
      String :name
      Boolean :completed?, :default => false
    end
    @tasks = @db[:task_table]
  end

  def create_task(task)
    @tasks.insert(task)
  end

  def read
    @tasks.to_a
  end

  def drop_table
    @db.drop_table :task_table
  end
end