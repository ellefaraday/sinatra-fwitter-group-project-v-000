require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'login'
  end

  get '/tweets' do
    erb :'tweets/index'
  end

  post '/login' do
      @user = User.find_by_username(params[:username])

      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        flash[:message] = "Logged in."
        redirect to "/users/#{@user.username}"
      else
        failure
      end
  end

  post '/signup' do
      @user = User.new(params)
      if @user.name && @user.email && @user.save
        session[:id] = @user.id
        redirect "/tweets"
      else
        flash[:message] = "Sign up failed please try again."
        redirect "/signup"
      end
  end

  get '/users/logout' do
    session.clear
    flash[:message] = "You have logged out."
    redirect to '/'
  end

  get '/users/:username' do
    @user= User.find_by_id(session[:id])
    erb :'users/show'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

end
