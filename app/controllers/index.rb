get '/' do
  current_user
  @flex = true
  erb :slide
end


get '/index2' do
  erb :index2
end
