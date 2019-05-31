class Users < Cuba
  define do
    on post do
      on param('user') do |user|
        on 'signup' do
          require 'pry'; binding.pry
          User.find_or_create(user['email'], user['password'])
        end

        on 'login' do

        end
      end
    end
  end
end
