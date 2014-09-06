get '/family/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @family = Family.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @family = Family.find_by(name: params[:search])
  end
  @taxonomy = @family.taxonomy
  @children = Genus.where(family: @family).limit(20).order("RANDOM()") # Postgres
                                            # switch to .order("RAND()") for MySQL
  erb :family
end
