require './tests/test_helper'
require 'override'

include Override

prepare do
  Ohm.flush
end

scope 'With invalid tokens' do
  test 'Reject request without token' do
    get '/tasks'
    assert_equal last_response.status, 401
  end

  test 'Reject request with a bad token' do
    header 'User-Token', 'bad-token'
    override User, get_email_from_token: nil
    get '/tasks'
    assert_equal last_response.status, 401
  end
end

scope 'With valid tokens' do
  test 'Reject request with a bad token' do
    User.create email: 'jack@mail.com', token: 'good-token'
    header 'User-Token', 'good-token'
    get '/tasks'
    assert_equal last_response.status, 200
    assert_equal User[1].attributes[:email], 'jack@mail.com'
  end
end
