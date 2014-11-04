require "./config/#{ ENV['RACK_ENV'] || 'development' }"

require 'ohm'
Ohm.redis = Redic.new(ENV['REDISTOGO_URL'])

#models
require './models/task'

#api
require './api/task'