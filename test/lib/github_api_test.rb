scope 'fetch email by username' do
  test 'return the email' do
    email = GithubAPI.fetch_email(ENV['GITHUB_API_TOKEN'])

    assert_equal email, 'costantinileandro1@gmail.com'
  end

  test 'raise an error when something went wrong' do
    assert_raise(GithubAPIError) do
      GithubAPI.fetch_email('abc123')
    end
  end
end
