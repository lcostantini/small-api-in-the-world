require './app'
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

prepare do
  Ohm.flush
end

Dir["./tests/*.rb"].each { |rb| require rb }
