# get "/" do
#    erb :index
# end

get '/species/random' do
  random_id = Species.all.pluck(:id).sample
  redirect "/species/#{random_id}"
end

get '/card/:id' do
  @species = Species.find(params[:id])
  @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(10)
  erb :card
end

#not finished. need to address edge cases
post '/add_to_collection' do
  if session[:user_id] != nil
    @user_collection = current_user.collections.first
    Card.create(user_id: current_user.id, species_id: params[:species_id], collection_id: @user_collection.id)
    content_type :json
    "success".to_json
  else
    content_type :json
    "try again".to_json
  end
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

post '/species/search' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%")
  redirect "/species/#{@species.id}"
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

get '/species/:search' do |search_result|
  unless search_result.nil?
    @species = Species.find(search_result.to_i)
    @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(20)
    @taxonomy = @species.taxonomy
    @wikiInfo = @species.parseWikipedia
    erb :species
  else
    redirect '/'
  end
end

get '/ajax/:parent/:level' do |parent, level|
  items = []
  images = [
    "",
    "/image/icon/bird-icon.png",
    "/image/icon/lion-icon.png",
    "/image/icon/lizard-icon.png",
    "/image/icon/frog-icon.png",
    "/image/icon/fish-icon.png"
  ]

  case level.to_i
    when 4
      Order.where(chlass_id: parent).pluck(:id, :name).each do |item|
        items << {id: item[0], name: item[1], image: images[parent.to_i]}
      end

    when 5
      Family.where(order_id: parent).pluck(:id, :name).each do |item|
        items << {id: item[0], name: item[1], image: images[1]}
      end
    when 6
      Genus.where(family_id: parent).pluck(:id, :name).each do |item|
        items << {id: item[0], name: item[1], image: images[1]}
      end
    when 7
      Species.where(genus_id: parent).pluck(:id, :common_name, :scientific_name, :image_name).each do |item|
        if item[1] != nil
          name = item[1]
        else
          name = item[2]
        end
        items << {id: item[0], name: name, image: item[3]}
      end
    end

    content_type :json
    items.to_json
end
