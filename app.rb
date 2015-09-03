require './config/application'

def authenticate!
  raise 'Unauthorized' unless current_user
end

def current_user
  @current_user ||= User.find_or_create env['HTTP_USER_TOKEN']
end

Cuba.define do
  begin

    authenticate!

    on 'tasks' do
      run Tasks
    end

  rescue StandardError => e
    on true do
      res.status = 401
      res.write errors: e.message
    end
  end
end
