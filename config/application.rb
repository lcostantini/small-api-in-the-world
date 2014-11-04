require "./config/#{ ENV['RACK_ENV'] || 'development' }"

require 'ohm'
Ohm.redis = Redic.new(ENV['REDISTOGO_URL'])

require './models/task'
