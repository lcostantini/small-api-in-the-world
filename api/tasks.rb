def merge_id_in_attr list
  list.to_a.map { |t| t.attributes.merge id: t.id }
end

def json_body
  JSON.parse req.body.read, symbolize_names: true
end

class Tasks < Cuba
  define do
    on get do
      on root do
        tasks = merge_id_in_attr current_user.tasks.find state: 'todo'
        res.write tasks.to_json
      end

      on 'all' do
        tasks = merge_id_in_attr current_user.tasks
        res.write tasks.to_json
      end

      on 'category', param('topic') do |query|
        res.write merge_id_in_attr(current_user.tasks.find(category: query)).to_json
      end
    end

    on post do
      task = current_user.tasks.add Task.create json_body[:task]
      res.write task
      res.status = 201
    end

    on ':id' do |id|
      task = Task[id]

      on put do
        on root do
          task = task.update json_body[:task].reject { |_, v| v.nil? }
          res.write task.attributes.to_json
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
        res.status = 200
      end
    end
  end
end
