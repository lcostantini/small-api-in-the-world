require 'ohm'

class Task < Ohm::Model
  attribute :name
  attribute :description
  attribute :created_at
  attribute :state

  index :name
  index :created_at
end
