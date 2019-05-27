ENV['REDISCLOUD_URL'] = 'redis://localhost:6379/2'

require './app'
require 'cutest'
require 'pry'
require 'rack/test'

class Cutest::Scope
  include Rack::Test::Methods

  def app
    Cuba
  end
end

prepare do
  Ohm.flush
end

Dir["./test/**/*.rb"].each { |rb| require rb }
