get '/species/random' do
  random_id = Species.all.pluck(:id).sample
  @species = Species.find(random_id)
  @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(10)
  # redirect "/species/#{random_id}"
  erb :card, layout: false
end

get '/card' do
  @species = Species.find(params[:animal_id])
  @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(10)
  erb :card, layout: false
end

#not finished. need to address edge cases
post '/add_to_collection' do
  
  @user_collection = current_user.collections.first
  if @card = Card.create(user_id: current_user.id, species_id: params["species_id"], collection_id: @user_collection.id)
    content_type :json
    @card.to_json
  else
    content_type :json
    "try again".to_json
  end
end

# get '/species' do
#   erb :"species/index"
# end

post '/species' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:species].downcase}%", "%#{params[:species].downcase}%")
  content_type :json
  { species: @species }.to_json
end

post '/species/search' do
  @species = Species.find_by("lower(common_name) LIKE ? OR lower(scientific_name) LIKE ?", "%#{params[:animal].downcase}%", "%#{params[:animal].downcase}%")
    @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(10)
  erb :card, layout: false
end

post '/speciesnames' do
  @all_species = Species.pluck(:common_name, :scientific_name)
  @all_species.flatten!.compact!

  content_type :json
  @all_species.to_json
end

get '/species/scrape_wikipedia' do

  # image_url = "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Collage_of_Nine_Dogs.jpg/260px-Collage_of_Nine_Dogs.jpg"

  # folder_names = Chlass.all.pluck('name')
  # species = Species.all.limit(10)
  # puts "Species Count = #{species.count}"
  # puts "Creating folders for each Class..."

  # folder_names.each do |name|
  #   system 'mkdir', '-p', "public/image/wiki/#{name}"
  # end

  puts "Preparing to get all image and descriptions from Wikipedia..."
  puts "Good Luck!"
  puts "*" * 50

  species = Species.where(image_name: nil)
  species.each do |s|
    begin
      info = s.parseWikipedia
      # s.wikitext = info[:intro]
      s.image_name = "http//" + info[:img]
      s.save
      # File.open("public/image/wiki/#{s.taxonomy['class']}/#{s.image_name}",'wb'){ |f| f.write(open("http:#{info[:img]}").read) }
    rescue
    end
  end
  redirect "/"
end

get '/species/:search' do |search_result|
  unless search_result.nil?
    @species = Species.find(search_result.to_i)
    @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(20)
    @taxonomy = @species.taxonomy
    # @wikiInfo = @species.parseWikipedia
    erb :card
  else
    redirect '/'
  end
end

get '/ajax/:parent/:level' do |parent, level|
  items = []

  case level.to_i
    when 4
      Order.where(chlass_id: parent).pluck(:id, :name, :image_name).each do |item|
        items << {id: item[0], name: item[1], image: item[2]}
      end

    when 5
      Family.where(order_id: parent).pluck(:id, :name, :image_name).each do |item|
        items << {id: item[0], name: item[1], image: item[2]}
      end
    when 6
      Genus.where(family_id: parent).pluck(:id, :name, :image_name).each do |item|
        items << {id: item[0], name: item[1].split(",")[0], image: item[2]}
      end
    when 7
      Species.where(genus_id: parent).pluck(:id, :common_name, :scientific_name, :image_name).each do |item|
        if item[1] != nil
          name = item[1]
        else
          name = item[2]
        end
        name = name.split(",")[0]
        items << {id: item[0], name: name, image: item[3]}
      end
    when 8
      puts "*"*50
      puts parent
      item = Species.find(parent.to_i)
      if item.common_name != nil
        name = item.common_name
      else
        name = item.scientific_name
      end
      items = {id: item.id, name: name, image: item.image_name, status: item.redListStatus, trend: item.population_trend, range: item.range, habitat: item.habitat, major_threats: item.major_threats}
    end

    content_type :json
    items.to_json
end

get '/preload/:parent/:level' do |parent, level|
  items = []
  parent = parent.to_i
  case level.to_i
    when 3
      Order.all.pluck(:image_name).each do |item|
        items << {image: item}
      end
    when 4
      Order.where(chlass_id: parent).pluck(:id).each do |order|
        Family.where(order_id: order).pluck(:image_name).each do |item|
          items << {image: item}
        end
      end
    when 5
      Family.where(order_id: parent).pluck(:id).each do |family|
        Genus.where(family_id: family).pluck(:image_name).each do |item|
          items << {image: item}
        end
      end
    when 6
      Genus.where(family_id: parent).pluck(:id).each do |genus|
        Species.where(genus_id: genus).pluck(:image_name).each do |item|
          items << {image: item}
        end
      end
    when 7
      items = {}
    when 8
      items = {}
    end

    content_type :json
    items.to_json
end
