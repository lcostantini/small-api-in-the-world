require './tests/test_helper'
require 'override'
include Override

prepare do
  Ohm.flush
end

scope 'With invalid tokens' do
  test 'Don\'t create a user without token' do
    get '/tasks'
    assert_equal User.all.count, 0
    assert_equal last_response.status, 401
  end

  test 'Don\'t create a user with a bad token' do
    header 'User-Token', 'bad-token'
    override User, email_from_token: nil
    get '/tasks'
    assert_equal User.all.count, 0
    assert_equal last_response.status, 401
  end
end

scope 'With valid tokens' do
  prepare do
    header 'User-Token', 'good-token'
  end

  test 'Create a user' do
    override User, email_from_token: 'jack@email.com'
    get '/tasks'
    assert_equal User.all.count, 1
    assert_equal User[1].attributes[:email], 'jack@email.com'
  end

  test 'Find an existing user' do
    User.create email: 'jack@email.com', token: 'good-token'
    get '/tasks'
    assert_equal last_response.status, 200
    assert_equal User.all.count, 1
    assert_equal User[1].attributes[:email], 'jack@email.com'
  end

  test 'Find an existing user if token is different' do
    User.create email: 'jack@email.com', token: 'good-token'
    header 'User-Token', 'other-good-token'
    override User, email_from_token: 'jack@email.com'
    get '/tasks'
    assert_equal last_response.status, 200
    assert_equal User.all.count, 1
    assert_equal User[1].attributes[:email], 'jack@email.com'
  end
end
