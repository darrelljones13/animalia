get '/' do  
  current_user
  erb :index
end


get '/index2' do
  erb :index2
end