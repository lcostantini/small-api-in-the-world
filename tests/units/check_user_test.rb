require './tests/test_helper'
require "rack/test"
require './app'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    MyTodo
  end
end

scope do
  test 'Reject request without api token' do
    get "/tasks"
    assert_equal last_response.status, 401
  end
end
