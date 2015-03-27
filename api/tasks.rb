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

    desc 'List all tasks for a specific category.'
    params do
      requires :topic, type: String, desc: "Task category."
    end
    get :category do
      Task.category(params[:topic]).map { |t| t.attributes.merge id: t.id }
    end

    desc "Update a task."
    params do
      requires :id, type: Integer, desc: "Task id."
    end
    route_param :id do

      desc "Update a task with params"
      put do
        task.update params[:task].reject { |k, v| v.nil? }
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
