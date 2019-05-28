require 'bcrypt'
require 'securerandom'

class User < Ohm::Model
  attribute :email
  attribute :password
  attribute :token
  unique :email
  unique :token
  set :tasks, :Task

  def self.sign_up(email, password)
    create(email: email,
           password: encrypt_password(password),
           token: SecureRandom.uuid)
  end

  def self.log_in_with_credentials(email, password)
    user = with(:email, email)

    return user if user&.correct_password?(password)

    nil
  end

  def self.log_in_with_token(token)
    with(:token, token)
  end

  def self.find_or_create(email, password)
    log_in_with_credentials(email, password) || sign_up(email, password)
  end

  def correct_password?(password)
    BCrypt::Password.new(self.password) == password
  end

  private

  def self.encrypt_password(password)
    BCrypt::Password.create(password)
  end
end
