require 'cuba'
require 'ohm'
require 'json'
require './api/tasks'
require './lib/github_api'

def validate_access!
  raise(StandardError, 'The file doesn\'t contain the token') if env['HTTP_USER_TOKEN'].empty?
  raise(StandardError, 'Unauthorized') unless current_user
end

def current_user
  @current_user ||= User.find_or_create env['HTTP_USER_TOKEN']
end

Ohm.redis = Redic.new(ENV['REDISCLOUD_URL'] || "redis://localhost:6379")

Dir["./models/*.rb"].each { |rb| require rb }
