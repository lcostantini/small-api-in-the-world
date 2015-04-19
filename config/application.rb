require "./config/#{ ENV['RACK_ENV'] || 'development' }"

require 'grape'
require 'ohm'
require 'json'
require './api/tasks'
Dir["./models/*.rb"].each { |rb| require rb  }

Ohm.redis = Redic.new(ENV['REDISTOGO_URL'])
