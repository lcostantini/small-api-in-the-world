require './config/application'

class MyTodo < Grape::API
  version 'v1', using: :header, vendor: 'saitw'
  format :json

  mount Tasks
end
