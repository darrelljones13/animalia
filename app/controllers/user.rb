post '/users/login' do
  user = User.find_by_email(params[:email])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
  end
  redirect '/'
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  p params
  User.create(params)
  erb :index
end

# register

get 'users/new' do
  erb :'users/new'
end

# POST ___________

# Login

post '/login' do
  @user = User.find_by(params[:email])
  if @user
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect '/'
  else
    @error = "Uh oh, login unsuccessful"
    erb :index
  end
end

# Register

post '/signup' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'users/new'
  end
end

# Logout

post '/logout' do
  session.clear
  redirect '/'
end
