

get "/" do
  erb :index
end


get '/species' do

  erb :"species/index"
end



post '/species' do
  @species = Species.where("common_name LIKE ? OR scientific_name LIKE ?", "%#{params[:species]}%", "%#{params[:species]}%").limit(20)
  content_type :json
  { species: @species }.to_json
end


