class Task < Ohm::Model

  attribute :name
  attribute :description
  attribute :created_at
  attribute :state

  index :name
  index :created_at
  index :state

  def self.todos
    find(state: 'todo')
  end

  def done!
    update state: 'done'
  end

  def undone!
    update state: 'todo'
  end

  def save
    initial_values if new?
    super
  end

  private

  def initial_values
    self.created_at = Date.today.to_s
    self.state = 'todo'
  end

end
