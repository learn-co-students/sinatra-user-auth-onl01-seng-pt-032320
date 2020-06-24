class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do
    #name: params["name"], email: params["email"], password: params["password"]
    @user = User.new(params[:user])
    @user.save
    
    session[:user_id] = @user.id # Adds a new key to session called :user_id and assignes it to the "id" attribute of @user
    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below renders the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(params[:user])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
