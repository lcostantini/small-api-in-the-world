require 'net/http'

class GithubAPI
  API_URI = URI('https://api.github.com/')

  class << self
    def fetch_email(token)
      response = http.get('/user', 'Authorization' => "token #{token}")

      res = handle_request(response)

      res['email']
    end

    private

    def handle_request(response)
      raise StandardError, response.message if response.code != '200'

      JSON.parse(response.body)
    end

    def http
      @http ||= Net::HTTP.new(API_URI.host, API_URI.port)
      @http.use_ssl = true

      @http
    end

    def token_file_path
      @token_file_path ||= File.expand_path(TOKEN_FILE_PATH)
    end
  end
end
