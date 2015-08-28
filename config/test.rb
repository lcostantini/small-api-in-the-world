require 'cutest'
require 'pry'

ENV['REDISTOGO_URL'] = "redis://localhost:6379/2"

require 'rack/test'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    Cuba
  end
end
