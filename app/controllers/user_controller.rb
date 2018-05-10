class UserController < ActiveRecord::Base
  get '/users/:username' do
    erb :'users/show'
  end
end
