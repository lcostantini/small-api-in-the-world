require './config/application'

class SAITW < Grape::API
  version 'v1', using: :header, vendor: 'saitw'
  format :json

  resource :task do
    desc "List al todos."
    get do
      { body: "list all todos" }
    end

    desc "List all tasks."
    get :all do
      Task.all.each do |task|
        "name: #{ task.name }"
      end
    end

    desc "Create a new task."
    params do
      requires :name, type: String, desc: "Name for the task."
    end
    post do
      Task.create({ name: params[:name] })
    end

    route_param :id do
      desc "Update a task with params."
      params do
        requires :name, type: String, desc: "Name for the task."
      end
      put do
        Task.find(params[:id]).update({ name: params[:name] })
      end

      desc "Mark a task as done."
      put :done do
        Task.find(params[:id]).done!
      end

      desc "Mark a task as undone."
      put :undone do
        Task.find(params[:id]).undone!
      end

      desc "Delete a task."
      delete do
        Task.find(params[:id]).destroy
      end
    end

  end

end
