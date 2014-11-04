require './config/application'

class MyTodo < Grape::API
  version 'v1', using: :header, vendor: 'saitw'
  format :json

  mount Tasks

  add_swagger_documentation({
    api_version: 'v1',
    hide_format: true,
    hide_documentation_path: true,
    info: {
      title: 'My Todo, The Smalest API in the world',
      description: 'A application to keep track of yout todo list',
      contact: '',
      license: 'GPL v3',
      license_url: 'todo',
      terms_of_service_url: 'todo'
    }
  })
end
