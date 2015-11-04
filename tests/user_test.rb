require 'override'
include Override

scope 'With invalid tokens' do
  setup do
    Ohm.flush
  end

  test 'Raise and error if token is nil' do
    get '/tasks'
    assert_equal User.all.count, 0
    assert_equal last_response.status, 401
  end

  test 'Raise and error if token is wrong' do
    header 'User-Token', 'bad-token'
    override User, email_from_token: nil
    get '/tasks'
    assert_equal User.all.count, 0
    assert_equal last_response.status, 401
  end
end

scope 'With valid tokens' do
  setup do
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
