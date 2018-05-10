class UserController < Sinatra::Base
  get '/users/:username' do
    erb :'users/show'
  end
end
