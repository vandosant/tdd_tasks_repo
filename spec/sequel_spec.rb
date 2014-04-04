require './lib/tasks_repository'

describe "tasks repository" do
  let (:db) {Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_repository_test')}

  before do
    db.create_table :task_table do
      primary_key :id
      String :name
      Boolean :completed, :default => false
    end
  end

  after do
    db.drop_table :task_table
  end

  it "allows you to create tasks" do
    tasks = TasksRepository.new(db)
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    actual = tasks.read
    expected = [{:id => 1, :name => "buy milk", :completed => false}, {:id => 2, :name => "buy chocolate", :completed => false}]

    expect(actual).to eq expected

  end

  it "lets you update a task" do
    tasks = TasksRepository.new(db)
    tasks.insert_row({:name => "buy milk"})
    tasks.update_row({:name => "buy milk"}, {:name => "buy bread"})
    actual = tasks.read
    expected = [{:id => 1, :name => "buy bread", :completed => false}]

    expect(actual).to eq expected

  end

  it "lets you delete a task" do
    tasks = TasksRepository.new(db)
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    tasks.delete_row({:name => "buy milk"})
    actual = tasks.read
    expected = [{:id => 2, :name => "buy chocolate", :completed => false}]

    expect(actual).to eq expected
  end

  it "is able to find a task by id" do
    tasks = TasksRepository.new(db)
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    actual = tasks.find(2)
    expected = [{:id => 2, :name => "buy chocolate", :completed => false}]

    expect(actual).to eq expected
  end
end