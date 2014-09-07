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

get '/logout' do
  session.clear
  erb :index
end

# register

get 'users/new' do
  erb :'users/new'
end

# profile (user collections)

get 'users/profile/:id' do
  @user = User.find(session[:user_id])
  @collections = @user.collections.all
  erb :profile
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


# Edit Collection

# Delete Collection
