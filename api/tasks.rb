def attributes tasks
  tasks.map(&:to_hash).to_json
end

def body_json
  JSON.parse req.body.read, symbolize_names: true
end

class Tasks < Cuba
  define do

    tasks = current_user.tasks

    on get do
      on root do
        res.write attributes tasks.find(state: 'todo')
      end

      on 'all' do
        res.write attributes tasks
      end

      on 'category', param('topic') do |query|
        res.write attributes tasks.find(category: query)
      end
    end

    on post do
      tasks.add Task.create body_json[:task]
      res.status = 201
    end

    on ':id' do |id|
      task = Task[id]

      on put do
        on root do
          task.update body_json[:task].reject { |_, v| v.nil? }
          res.status = 204
        end

        on 'done' do
          task.done!
          res.status = 204
        end

        on 'undone' do
          task.undone!
          res.status = 204
        end
      end

      on delete do
        tasks.delete task
        res.status = 204
      end
    end

  end
end
