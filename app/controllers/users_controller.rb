require 'rack-flash'
class UsersController < ApplicationController
  use Rack::Flash
  get '/users/logout' do
    session.clear
    flash[:message] = "You have logged out."
    redirect to '/'
  end

  get '/users/:username' do
    @user= User.find_by_id(session[:id])
    erb :'users/show'
  end
end
