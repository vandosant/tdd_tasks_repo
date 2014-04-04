require './lib/tasks_repository'

describe "database" do
  it "it allows you to create tasks" do
    tasks = TasksRepository.new
    tasks.create_table
    tasks.insert_row({:name => "buy milk"})
    tasks.insert_row({:name => "buy chocolate"})
    actual = tasks.read
    expected = [{:id => 1, :name => "buy milk", completed?: false}, {:id => 2, :name => "buy chocolate", completed?: false}]

    expect(actual).to eq expected

  end
end