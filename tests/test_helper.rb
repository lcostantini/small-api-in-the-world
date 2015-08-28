ENV['RACK_ENV'] = 'test'

require './app'

prepare do
  Ohm.flush
end
