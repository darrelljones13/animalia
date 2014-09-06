get '/genus/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @genus = Genus.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @genus = Genus.find_by(name: params[:search])
  end
  @taxonomy = @genus.taxonomy
  @relatives = Species.where("genus_id = ?", "#{@genus.id}").limit(20)
  erb :genus
end
