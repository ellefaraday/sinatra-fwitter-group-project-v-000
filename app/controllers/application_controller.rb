require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end

  get '/sign-up' do
    erb :'users/new'
  end

  get '/login' do
    erb :'login'
  end

  post '/login' do
      @user = User.find_by_username(params[:username])

      if @user && User.authenticate(params[:password])
        session[:id] = @user.id
        success
        redirect to '/users/:username'
      else
        failure
      end
  end

  post '/sign-up' do
      binding.pry
      @user = User.new(params)
      if user.save
        session[:id] = @user.id
        redirect "/users/#{@user.username}"
      else
        flash[:message] = "Sign up failed please try again."
        redirect "/sign-up"
      end
  end
end
