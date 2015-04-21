class User < Ohm::Model
  attribute :email
  attribute :token
  unique :token
  unique :email
  set :tasks, :Task

  def self.find_or_create token
    with(:token, token) or
      create(email: get_email_from_token(token), token: token)
  end

  def self.create *args
    return nil unless args[0][:email]
    super
  end

  private

  def self.get_email_from_token token
    valid_user = JSON.parse `curl -u #{ token }:x-oauth-basic https://api.github.com/user`
    valid_user['email']
  end
end
