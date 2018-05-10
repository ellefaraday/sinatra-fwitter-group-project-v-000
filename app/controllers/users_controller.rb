
class UsersController < ApplicationController
  get '/users/:username' do
    @user= User.find_by_id(session[:id])
    erb :'users/show'
  end
end
