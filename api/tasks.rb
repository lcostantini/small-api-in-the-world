class Tasks < Grape::API

  helpers do
    def task
      @task ||= Task.find params[:id]
    end
  end

  resource :tasks do

    desc "List all todos"
    get do
      Task.todos
    end

    desc "List all tasks"
    get :all do
      Task.all
    end

    desc "Create a new task"
    post do
      Task.create params[:task]
    end

    route_param :id do

      desc "Update a task with params"
      put do
        task.update params[:task]
      end

      desc "Mark a task as done"
      put :done do
        task.done!
      end

      desc "Mark a task as undone"
      put :undone do
        task.undone!
      end

      desc "Delete a task"
      delete do
        task.destroy
      end
    end

  end

end
