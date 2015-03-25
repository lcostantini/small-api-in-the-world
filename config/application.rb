require "./config/#{ ENV['RACK_ENV'] || 'development' }"

require 'grape'
require 'ohm'
Ohm.redis = Redic.new(ENV['REDISTOGO_URL'])

require './models/task'
require './api/tasks'
