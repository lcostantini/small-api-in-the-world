require './config/application'

Cuba.define do
  on 'tasks' do
    run Tasks
  end
end
