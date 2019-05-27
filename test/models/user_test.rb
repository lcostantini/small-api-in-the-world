require 'override'
include Override

def json_body
  JSON.parse last_response.body, symbolize_names: true
end

scope 'User' do
  setup do
    user = User.create(email: 'john@doe.com', token: ['abc123'])

    ['foo', 'bar'].each { |name| user.tasks.add(Task.create(name: name)) }

    user
  end

  test 'get the tasks for a user' do |user|
    assert_equal user.tasks.count, 2
  end

  test 'save multiple tokens to the same user' do |user|
    user.token << 'xyz789'

    assert_equal user.token, ['abc123', 'xyz789']
  end
end

# scope 'With invalid tokens' do
#   test 'Raise and error if token is empty' do
#     header 'User-Token', ''
#     get '/tasks'
#     assert_equal json_body[:errors], 'The file doesn\'t contain the token'
#     assert_equal last_response.status, 401
#   end
#
#   test 'Raise and error if token is wrong' do
#     header 'User-Token', 'bad-token'
#     override User, email_from_token: nil
#     get '/tasks'
#     assert_equal User.all.count, 0
#     assert_equal last_response.status, 401
#   end
# end
#
# scope 'With valid tokens' do
#   setup do
#     header 'User-Token', 'good-token'
#   end
#
#   test 'Create a user' do
#     override User, email_from_token: 'jack@email.com'
#     get '/tasks'
#     assert_equal User.all.count, 1
#     assert_equal User[1].attributes[:email], 'jack@email.com'
#   end
#
#   test 'Find an existing user' do
#     User.create email: 'jack@email.com', token: 'good-token'
#     get '/tasks'
#     assert_equal last_response.status, 200
#     assert_equal User.all.count, 1
#     assert_equal User[1].attributes[:email], 'jack@email.com'
#   end
#
#   test 'Find an existing user if token is different' do
#     User.create email: 'jack@email.com', token: 'good-token'
#     header 'User-Token', 'other-good-token'
#     override User, email_from_token: 'jack@email.com'
#     get '/tasks'
#     assert_equal last_response.status, 200
#     assert_equal User.all.count, 1
#     assert_equal User[1].attributes[:email], 'jack@email.com'
#   end
# end
