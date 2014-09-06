get '/phylum/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @phylum = Phylum.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @phylum = Phylum.find_by(name: params[:search])
  end
  puts ""
  @taxonomy = @phylum.taxonomy
  @children = Chlass.where(phylum_id: @phylum.id).limit(20).order("RANDOM()") # Postgres
                                            # switch to .order("RAND()") for MySQL
  erb :phylum
end
