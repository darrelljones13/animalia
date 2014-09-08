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
  content_type :json
  { species: @species }.to_json
end

post '/speciesnames' do
  @all_species = Species.pluck(:common_name, :scientific_name)
  @all_species.flatten!.compact!

  content_type :json
  @all_species.to_json
end

get '/species/scrape_wikipedia' do

  image_url = "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Collage_of_Nine_Dogs.jpg/260px-Collage_of_Nine_Dogs.jpg"

  folder_names = Chlass.all.pluck('name')
  species = Species.all.limit(10)
  puts "Species Count = #{species.count}"
  puts "Creating folders for each Class..."
  
  folder_names.each do |name|
    system 'mkdir', '-p', "public/image/wiki/#{name}"
  end

  puts "Preparing to get all image and descriptions from Wikipedia..."
  puts "Good Luck!"
  puts "*" * 50

  species.each do |s|
    info = s.parseWikipedia
    s.wikitext = info[:intro]
    s.image_name = File.basename(info[:img])

    File.open("public/image/wiki/#{s.taxonomy['class']}/#{s.image_name}",'wb'){ |f| f.write(open("http:#{info[:img]}").read) }
    print "X"
  end

  redirect "/"
end

post '/species/search' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%")
  redirect "/species/#{@species.id}"
end

get '/species/:search' do 
  if params[:search] == nil
    redirect '/'
  elsif params[:search].to_i > 0
    puts "Search by integer"
    @species = Species.find(params[:search].to_i)
  else
    puts "Search by name #{params[:search]}"
    @species = Species.find_by(common_name: params[:search])
    if @species == nil
      redirect '/'
    end
  end
  @relatives = Species.where("genus_id = ? AND id != #{@species.id}", "#{@species.genus_id}").limit(20)
  @taxonomy = @species.taxonomy
  @wikiInfo = @species.parseWikipedia
  erb :species
end
