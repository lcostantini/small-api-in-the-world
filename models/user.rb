class User < Ohm::Model
  attribute :email
  attribute :token
  unique :token
  set :tasks, :Task
end
