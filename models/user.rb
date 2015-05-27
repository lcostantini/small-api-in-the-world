class User < Ohm::Model
  attribute :email
  attribute :token
  unique :token
  unique :email
  set :tasks, :Task

  def self.find_or_create token
    with(:token, token) ||
      with(:email, email_from_token(token)) ||
        create(email: email_from_token(token), token: token)
  end

  def self.create args
    raise 'The token was invalid and no return an email.' unless args[:email]
    super
  end

  private

  def email_from_token token
    @email ||= JSON.parse(`curl -u #{ token }:x-oauth-basic https://api.github.com/user`)['email']
  end
end
