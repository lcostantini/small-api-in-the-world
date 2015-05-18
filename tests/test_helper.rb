ENV['RACK_ENV'] = 'test'

require './app'
require 'rack/test'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    Cuba
  end
end
