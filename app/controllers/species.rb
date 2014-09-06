# require 'json'

get "/" do
   # hierarchy.to_json
end

get '/species' do

  erb :"species/index"
end

post '/species' do

  @species = Species.where("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%").limit(20)
  content_type :json
  { species: @species }.to_json
end


post '/speciesnames' do
  @all_species = Species.pluck(:common_name, :scientific_name)
  @all_species.flatten!.compact!

  content_type :json
  @all_species.to_json
end


