get '/' do
  current_user
  random_id = Species.all.pluck(:id).sample
  @species = Species.find(random_id)
  @relatives = Species.where("genus_id = ? AND id != ?", @species.genus_id, @species.id).limit(10)
  @flex = true
  erb :slide
end

get '/index2' do
  erb :index2
end
