get '/order/:search' do
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @order = Order.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    # TODO needs error handling
    @order = Order.find_by(name: params[:search])
  end
  @taxonomy = @order.taxonomy
  @children = Family.where(order: @order).limit(20).order("RANDOM()") # Postgres
                                            # switch to .order("RAND()") for MySQL
  erb :order
end
