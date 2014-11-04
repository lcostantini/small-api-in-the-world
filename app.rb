require './config/application'

class SAITW < Grape::API
  version 'v1', using: :header, vendor: 'saitw'
  format :json

  mount SAITW::Task
end
