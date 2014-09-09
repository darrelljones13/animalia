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


get '/species/scrape_wikipedia' do
  puts "Preparing to get all image and descriptions from Wikipedia..."
  puts "Good Luck!"
  puts "*" * 50

  genus = Genus.all
  genus.each do |s|
    begin
      info = g.parseWikipedia
      # s.wikitext = info[:intro]
      g.image_name = "http:" + info[:img]
      g.save
      # File.open("public/image/wiki/#{s.taxonomy['class']}/#{s.image_name}",'wb'){ |f| f.write(open("http:#{info[:img]}").read) }
    rescue
    end
  end
  redirect "/"
end
