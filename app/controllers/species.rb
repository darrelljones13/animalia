

get "/" do
  erb :index
end


get '/species' do

  erb :"species/index"
end



post '/species' do

  @species = Species.where("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%").limit(20)
  content_type :json
  { species: @species }.to_json
end


