get '/family/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @family = Family.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @family = Family.where(name: params[:search])
  end
  p @family
  @relatives = Species.where(family: @family).limit(20)
  erb :family
end
