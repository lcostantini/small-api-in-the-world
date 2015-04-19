ENV['RACK_ENV'] = 'test'

require './config/application'
require './app'
require 'rack/test'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    MyTodo
  end
end
