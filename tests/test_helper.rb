ENV['RACK_ENV'] = 'test'

require './config/application'

prepare do
  Ohm.flush
end
