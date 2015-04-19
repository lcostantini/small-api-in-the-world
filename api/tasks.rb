class Tasks < Grape::API
  helpers do
    def task
      @task ||= Task[params[:id]]
    end

    def current_user
      @current_user ||= User.find_or_create headers['User-Token']
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless headers['User-Token'] &&
                                             current_user
    end

    def merge_id_in_attr list
      list.to_a.map { |t| t.attributes.merge id: t.id }
    end
  end

  before do
    authenticate!
  end

  resource :tasks do

    desc "List all todos"
    get do
      merge_id_in_attr current_user.tasks.find state: 'todo'
    end

    desc "List all tasks"
    get :all do
      current_user.tasks
    end

    desc "Create a new task"
    post do
      current_user.tasks.add Task.create params[:task]
    end

    desc 'List all tasks for a specific category.'
    params do
      requires :topic, type: String, desc: "Task category."
    end
    get :category do
      merge_id_in_attr current_user.tasks.find category: params[:topic]
    end

    desc "Operating on a task."
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
        current_user.tasks.delete task
      end
    end

  end
end
