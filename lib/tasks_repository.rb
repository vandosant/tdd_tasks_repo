require 'sequel'

class TasksRepository
  attr_accessor :db

  def initialize
    @db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_repository_test')
    @table = @db[:task_table]
  end

  def create_table
    @db.create_table! :task_table do
      primary_key :id
      String :name
      Boolean :completed?, :default => false
    end
  end

  def insert_row(task)
    @table.insert(task)
  end

  def read
    @table.to_a
  end
end