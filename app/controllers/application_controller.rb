require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get('/') {
    erb :index
  }

  get('/signup') {
    if logged_in?
      redirect '/tweets'
    else
      erb :signup
    end
  }

  get('/logout') {
    session.clear
    redirect '/login'
  }



  get('/login') {
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  }

  post('/login') {
    user = User.find_by(username: params[:username])    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  }

  post('/signup') {
    username = params[:username]
    email = params[:email]
    password = params[:password]

    isEmpty = false
    params.each{ |k,v| 
      isEmpty = v.empty?
      break if isEmpty
    }
    if isEmpty
      redirect '/signup'
    else
      user = User.create(username: username, email: email, password: password)
      session[:user_id] = user.id
      redirect '/tweets'
    end
    
  }

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    
  end

end
