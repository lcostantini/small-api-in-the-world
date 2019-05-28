scope '#sign_up' do
  test 'returns a user with a token' do
    user = User.sign_up('foo@bar.com', 'pass')

    assert !user.token.nil?
  end
end

scope '#log_in_with_credentials' do
  test 'returns a user with the correct credentials' do
    assert !User.log_in_with_credentials('jon@snow.com', 'pass').nil?
  end

  test 'returns nil when the the user does not exists' do
    assert User.log_in_with_credentials('new_user@email.com', 'pass').nil?
  end

  test 'returns nil when the password is incorrect' do
    assert User.log_in_with_credentials('jon@snow.com', 'invalid pass').nil?
  end
end

scope '#find_or_create ' do
  test 'returns a user when is in the DB' do
    total_users =  User.all.count

    assert !User.find_or_create('jon@snow.com', 'pass').nil?
    assert_equal User.all.count, total_users
  end

  test 'returns a user after creation' do
    total_users =  User.all.count

    assert !User.find_or_create('sansa@stark.com', 'pass').nil?
    assert_equal User.all.count, (total_users + 1)
  end
end
