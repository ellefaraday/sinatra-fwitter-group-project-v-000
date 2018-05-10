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
    erb :'sign-up'
  end

  get '/login' do
    erb :'login'
  end

  post '/login' do
     redirect to '/users/:username'
  end
  
  post '/sign-up' do
     redirect to '/users/:username'
  end
end
