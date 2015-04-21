def current_user
  @current_user ||= User.find_or_create env["HTTP_USER_TOKEN"]
end

def authenticate!
  raise(StandardError, 'Unauthorized') unless env['HTTP_USER_TOKEN'] &&
                                              current_user
end

def merge_id_in_attr list
  list.to_a.map { |t| t.attributes.merge id: t.id }
end

def json_body
  JSON.parse req.body.read, symbolize_names: true
end

class Tasks < Cuba
  define do
    begin

      authenticate!

      on get do
        on root do
          res.write merge_id_in_attr(current_user.tasks.find(state: 'todo')).to_json
        end

        on 'all' do
          res.write current_user.tasks.to_json
        end

        on 'category', param('topic') do |query|
          res.write merge_id_in_attr(current_user.tasks.find(category: query)).to_json
        end
      end

      on post do
        res.write current_user.tasks.add Task.create json_body[:task]
      end

      on ':id' do |id|
        task = Task[id]

        on put do
          on param('task') do |params|
            res.write task.update params.reject { |_, v| v.nil? }
          end

          on 'done' do
            res.write task.done!
          end

          on 'undone' do
            res.write task.undone!
          end
        end

        on delete do
          current_user.tasks.delete task
        end
      end

    rescue StandardError => e
      on true do
        res.status = 401
        res.write errors: e.message
      end
    end

  end
end
