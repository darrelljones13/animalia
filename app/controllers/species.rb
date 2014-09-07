# get "/" do
#    erb :index
# end

get '/species/random' do
  random_id = Species.all.pluck(:id).sample
  redirect "/species/#{random_id}"
end


get'/species/:species_id/show' do
  erb :"species/show"
end

get '/species' do

  erb :"species/index"
end

post '/species' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%")
  puts @species.id
  # redirect '/species/#{@species.id}'
  content_type :json
  { species: @species }.to_json
end

post '/species/search' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%")
  puts @species.id
  redirect "/species/#{@species.id}"
end

post '/speciesnames' do
  @all_species = Species.pluck(:common_name, :scientific_name)
  @all_species.flatten!.compact!

  content_type :json
  @all_species.to_json
end

get '/species/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @species = Species.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @species = Species.where(common_name: params[:search])
  end
  @relatives = Species.where("genus_id = ? AND id != #{@species.id}", "#{@species.genus_id}").limit(20)
  @taxonomy = @species.taxonomy
  @wikiInfo = @species.parseWikipedia
  erb :species
end
