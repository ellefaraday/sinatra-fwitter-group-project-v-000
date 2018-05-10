
class UsersController < ApplicationController
  get '/users/:username' do
    erb :'users/show'
  end
end
