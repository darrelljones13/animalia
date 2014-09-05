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
  p @relatives
  @wikiInfo = @species.parseWikipedia
  erb :species
end


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
