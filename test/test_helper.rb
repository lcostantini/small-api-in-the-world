ENV['REDISCLOUD_URL'] = 'redis://localhost:6379/2'

require './config/application'
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

  User.sign_up('jon@snow.com', 'pass')
end

Dir["./test/**/*.rb"].each { |rb| require rb }
