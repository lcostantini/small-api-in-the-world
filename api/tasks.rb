class Tasks < Grape::API

  helpers do
    def task
      @task ||= Task[params[:id]]
    end
  end

  resource :tasks do

    desc "List all todos"
    get do
      Task.todos.map { |t| t.attributes.merge id: t.id }
    end

    desc "List all tasks"
    get :all do
      Task.all.map { |t| t.attributes.merge id: t.id }
    end

    desc "Create a new task"
    post do
      Task.create params[:task]
    end

    desc "Update a task."
    params do
      requires :id, type: Integer, desc: "Task id."
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
        task.delete
      end
    end

  end

end
