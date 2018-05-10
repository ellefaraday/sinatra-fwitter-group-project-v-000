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
     redirect to '/users/:username'
  end

  post '/sign-up' do
      binding.pry
      @user = User.create(params)
     redirect to '/users/:username'
  end
end
