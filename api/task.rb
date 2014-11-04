class SAITW::Task < Grape::API

  resource :task do
    desc "List all todos"
    get do
    end

    desc "List all tasks"
    get :all do
    end

    desc "Create a new task"
    post do
    end

    route_param :id do
      desc "Update a task with params"
      put do
      end

      desc "Mark a task as done"
      put :done do
      end

      desc "Mark a task as undone"
      put :undone do
      end

      desc "Delete a task"
      delete do
      end
    end

  end

end
