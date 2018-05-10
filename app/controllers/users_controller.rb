require './config/environment'

class UsersController < Sinatra::Base
  get '/users/:username' do
    erb :'/users/show'
  end
end
