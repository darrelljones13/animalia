get '/' do
  erb :index
end

post '/users/login' do
  user = User.find_by_email(params[:email])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
  end
  redirect '/'
end

get '/users/logout' do
  session[:user_id] = nil
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