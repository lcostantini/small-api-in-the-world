require "./config/#{ ENV['RACK_ENV'] || 'development' }"

require 'cuba'
require 'ohm'
require 'json'
require './api/tasks'
Dir["./models/*.rb"].each { |rb| require rb  }

Ohm.redis = Redic.new ENV['REDISTOGO_URL']
