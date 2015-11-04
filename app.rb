require 'cuba'
require 'ohm'
require 'json'
require './api/tasks'
Dir["./models/*.rb"].each { |rb| require rb  }

Ohm.redis = Redic.new(ENV['REDISTOGO_URL'] || "redis://localhost:6379")

def validate_access!
  raise(StandardError, 'The file doesn\'t contain the token') if env['HTTP_USER_TOKEN'].empty?
  raise(StandardError, 'Unauthorized') unless current_user
end

def current_user
  @current_user ||= User.find_or_create env['HTTP_USER_TOKEN']
end

Cuba.define do
  begin

    validate_access!

    on 'tasks' do
      run Tasks
    end

  rescue StandardError => e
    on true do
      res.status = 401
      res.write "{ \"errors\": \"#{ e.message }\" }"
    end
  end
end
