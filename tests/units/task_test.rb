require './tests/test_helper'

scope do
  setup do
    @task = Task.create name: 'Test api', category: 'testing'
  end

  test 'Task is saved' do
    assert_equal Task.all.count, 1
  end

  test 'A task must be on "todo" state when is created' do
    assert_equal @task.state, 'todo'
  end

  test '#todos should show all the task whit todo state' do
    assert_equal Task.todos.count, 1
  end

  test '#done! should set a task as done' do
    @task.done!
    assert_equal @task.state, 'done'
    assert_equal Task.todos.count, 0
  end

  test '#all should show all the task' do
    assert_equal Task.all.count, 1
  end

  test '#categories should return all the task with some category' do
    assert_equal Task.categories('testing').count, 1
  end

  test 'update a task' do
    @task.update category: 'update'
    assert_equal @task.category, 'update'
  end

  test 'delete a task' do
    @task.delete
    assert_equal Task.all.count, 0
  end
end
