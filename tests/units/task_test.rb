require './tests/test_helper'

scope do

  setup do
    @task = Task.create name: 'Learn Angular'
  end

  test 'save task' do
    assert Task.all.count == 1
  end

  test 'a task must be on "todo" state when is created' do
    #assert @task.state == 'todo'
  end

  test '#todos should show all the task whit todo state' do
    #assert Task.todos.count == 1
  end

  test '#done! should set a task as done' do
    #@task.done!
    #assert task.state == 'done'
    #assert Task.todos.count == 0
  end

end