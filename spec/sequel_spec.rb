require './lib/tasks_repository'

describe "tasks repository" do
  it "allows you to create tasks" do
    tasks = TasksRepository.new
    tasks.create_table
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    actual = tasks.read
    expected = [{:id => 1, :name => "buy milk", :completed => false}, {:id => 2, :name => "buy chocolate", :completed => false}]

    expect(actual).to eq expected

  end

  it "lets you update a task" do
    tasks = TasksRepository.new
    tasks.create_table
    tasks.insert_row({:name => "buy milk"})
    tasks.update_row({:name => "buy milk"}, {:name => "buy bread"})
    actual = tasks.read
    expected = [{:id => 1, :name => "buy bread", :completed => false}]

    expect(actual).to eq expected

  end

  it "lets you delete a task" do
    tasks = TasksRepository.new
    tasks.create_table
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    tasks.delete_row({:name => "buy milk"})
    actual = tasks.read
    expected = [{:id => 2, :name => "buy chocolate", :completed => false}]

    expect(actual).to eq expected
  end
end