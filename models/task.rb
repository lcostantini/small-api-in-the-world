class Task < Ohm::Model
  attribute :name
  attribute :description
  attribute :created_at
  attribute :state

  index :name
  index :created_at

  def self.todos
    Task.all
  end

  def done!
    self.state = 'Completed'
  end

  def undone!
    self.state = 'todo'
  end
end
