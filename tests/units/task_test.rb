require './tests/test_helper'

def user
  @user ||= User.with :token, 'good-token'
end

def task_body
  { task: { name: 'Make coffee',
            category: 'testing' } }
end

def task
  user.tasks.add Task.create task_body[:task]
end

def body_json
  JSON.parse last_response.body, symbolize_names: true
end

scope 'With valid user' do
  setup do
    User.create email: 'jack@mail.com', token: 'good-token'
    header 'User-Token', 'good-token'
  end

  test 'User\'s todo tasks' do
    task
    get '/tasks'
    assert_equal body_json.size, 1
  end

  test 'Get all tasks for a specific category' do
    task
    get '/tasks/category?topic=testing'
    assert_equal body_json.first[:name], 'Make coffee'
  end

  test 'Create a new task' do
    post '/tasks', task_body.to_json
    assert_equal user.tasks.count, 1
    assert_equal last_response.status, 200
  end

  test 'Update a task' do
    put "/tasks/#{ task }", { task: { name: 'Make mates' } }.to_json
    assert_equal user.tasks.first.attributes[:name], 'Make mates'
  end

  test 'Mark a task as done' do
    put "/tasks/#{ task }/done"
    assert_equal user.tasks.first.attributes[:state], 'done'
  end

  test 'Mark a task as undone' do
    put "/tasks/#{ task }/undone"
    assert_equal user.tasks.first.attributes[:state], 'todo'
  end

  test 'Delete a task' do
    delete "/tasks/#{ task }"
    assert_equal user.tasks.count, 0
    assert_equal last_response.status, 200
  end

  test 'Get all the tasks' do
    user.tasks.add Task.create name: 'Now is make'
    put "/tasks/#{ task }/done"
    assert_equal user.tasks.count, 2

    get '/tasks/all'
    assert_equal body_json.size, 2
  end
end
