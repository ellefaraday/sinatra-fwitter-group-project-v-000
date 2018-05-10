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
    if Helper.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/new'
    end
  end

  get '/login' do
    erb :'login'
  end

  get '/tweets' do
    erb :'tweets/index'
  end

  post '/login' do
    if Helper.is_logged_in?(session)
      redirect to '/tweets'
    else
      @user = User.find_by_username(params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        flash[:message] = "Welcome,"
        redirect to "/tweets"
      else
        failure
      end
    end
  end

  post '/signup' do
      @user = User.new(params)
      if @user.username != "" && @user.email != "" && @user.save
        session[:user_id] = @user.id
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
    @user= User.find_by_id(session[:user_id])
    erb :'users/show'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

end
