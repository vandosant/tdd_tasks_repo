require 'sequel'

class TasksRepository
  attr_accessor :db

  def initialize(db)
    @table = db[:task_table]
  end

  def insert_row(new_row)
    @table.insert(new_row)
  end

  def update_row(existing_row, new_value)
    @table.where(existing_row).update(new_value)
  end

  def delete_row(row_to_delete)
    @table.where(row_to_delete).delete
  end

  def find(id)
    @table.where(:id => id).to_a
  end

  def read
    @table.to_a
  end
end