require './tests/test_helper'
require 'rack/test'
require './app'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    MyTodo
  end
end

def current_user
  @user ||= User.with :token, 'good-token'
end

scope do
  prepare do
    User.create email: 'pato-manager', token: 'good-token'
  end

  test 'Reject request without api token' do
    get '/tasks'
    assert_equal last_response.status, 401
  end

  test 'With a good api token it works' do
    get '/tasks', api_token: 'good-token'
    assert_equal last_response.status, 200
  end

  test 'List the task of the user' do
    current_user.tasks.add Task.create name: 'user task', category: 'testing'
    get '/tasks', api_token: 'good-token'
    assert_equal JSON.parse(last_response.body).class, Array
  end
end
