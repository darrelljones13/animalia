get '/class/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @class = Chlass.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @class = Chlass.find_by(name: params[:search])
  end
  puts ""
  @taxonomy = @class.taxonomy
  @children = Order.where(chlass_id: @class.id).limit(20).order("RANDOM()") # Postgres
                                            # switch to .order("RAND()") for MySQL
  erb :class
end
