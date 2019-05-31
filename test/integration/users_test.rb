scope '/users' do
  test '/signup returns a new user' do
    total_users = User.all.count

    post '/users/signup', { user: { email: 'new_user@email.com', password: 'pass' } }

    assert_equal User.all.count, (total_users + 1)
  end

  test '/signup returns an existing user' do

  end
end
