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
  @relatives = Species.where(genus_id: @species.genus_id).limit(5)
  p @relatives
  @wikiInfo = @species.parseWikipedia
  erb :species
end
