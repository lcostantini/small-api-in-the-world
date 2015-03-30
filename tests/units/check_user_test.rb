require './tests/test_helper'
require "rack/test"
require './app'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    MyTodo
  end
end

class User
  def self.find token
    new if token == 'good-token'
  end
end

scope do
  test 'Reject request without api token' do
    get '/tasks'
    assert_equal last_response.status, 401
  end

  test 'With a good api token it works' do
    get '/tasks', api_token: 'good-token'
    assert_equal last_response.status, 200
  end
end
