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
    if Helper.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'login'
    end
  end

  get '/tweets' do
    if Helper.is_logged_in?(session)
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helper.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "You have logged out."
    redirect to '/login'
  end

  get '/users/:slug' do
    if Helper.is_logged_in?(session) && Helper.current_user(session).slug == params[:slug]
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome,"
      redirect to "/tweets"
    else
      failure
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

  post '/tweets' do
    #@tweet = Tweet.create(content: params, user_id:session[:user_id])
  end

end
