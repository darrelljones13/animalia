require 'csv'

class Parser

  def self.seed_birds
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Aves", phylum_id: Phylum.last.id)

    CSV.foreach('birds_proper.csv', :headers => true) do |bird|
      Order.create(name: bird["Order"], chlass_id: Chlass.last.id)
      Family.create(name: bird["Family"], order_id: Order.last.id)
      Genus.create(name: bird["Scientific name"].split(" ")[0], family_id: Family.last.id)
      species = Species.create(
        genus_id: Genus.last.id,
        common_name: bird["Common name"],
        scientific_name: bird["Scientific name"],
        red_list_status: bird["2014 IUCN Red List category"],
        red_list_id: bird["SISRecID"])
      species.update(species.parse_red_list)
      species.save
    end
  end

  def self.seed_mammals
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Mammalia", phylum_id: Phylum.last.id)

    CSV.foreach('Mammals_Higher_Taxonomy_8.csv', :headers => true) do |mammal|
      Order.create(name: mammal["Order"], chlass_id: Chlass.last.id)
      Family.create(name: mammal["Family"], order_id: Order.last.id)
      Genus.create(name: mammal["Genus"], family_id: Family.last.id)

      species = Species.create(
        genus_id: Genus.last.id,
        common_name: mammal["Common names (Eng)"],
        scientific_name: "#{mammal["Genus"]} #{mammal["Species"]}",
        red_list_status: mammal["Red List status"],
        population_trend: mammal["Population trend"],
        red_list_id: mammal["Species ID"])
      species.update(species.parse_red_list)
      species.save
    end
  end

  def self.seed_reptiles
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Reptilia", phylum_id: Phylum.last.id)

    CSV.foreach('Reptiles_Higher_Taxonomy_8.csv', :headers => true) do |reptile|

      Order.create(name: reptile["Order"], chlass_id: Chlass.last.id)
      Family.create(name: reptile["Family"], order_id: Order.last.id)
      Genus.create(name: reptile["Genus"], family_id: Family.last.id)
      species = Species.create!(
        genus_id: Genus.last.id,
        common_name: reptile["Common names (Eng)"],
        scientific_name: "#{reptile["Genus"]} #{reptile["Species"]}",
        red_list_status: reptile["Red List status"],
        population_trend: reptile["Population trend"],
        red_list_id: reptile["Species ID"])
      species.update(species.parse_red_list)
      species.save
    end
  end

  def self.seed_amphibians
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Amphibia", phylum_id: Phylum.last.id)

    CSV.foreach('Amphibians_Higher_Taxonomy_8.csv', :headers => true) do |amphibian|

      Order.create(name: amphibian["Order"], chlass_id: Chlass.last.id)
      Family.create(name: amphibian["Family"], order_id: Order.last.id)
      Genus.create(name: amphibian["Genus"], family_id: Family.last.id)
      species = Species.create(
        genus_id: Genus.last.id,
        common_name: amphibian["Common names (Eng)"],
        scientific_name: "#{amphibian["Genus"]} #{amphibian["Species"]}",
        red_list_status: amphibian["Red List status"],
        population_trend: amphibian["Population trend"],
        red_list_id: amphibian["Species ID"])

      species.update(species.parse_red_list)
      species.save
    end
  end

  def self.seed_marine_life
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Osteichthyes", phylum_id: Phylum.last.id)

    CSV.foreach('MarineFish_Higher_Taxonomy_8.csv', :headers => true) do |fish|

      Order.create(name: fish["Order"], chlass_id: Chlass.last.id)
      Family.create(name: fish["Family"], order_id: Order.last.id)
      Genus.create(name: fish["Genus"], family_id: Family.last.id)
      species = Species.create(
        genus_id: Genus.last.id,
        common_name: fish["Common names (Eng)"],
        scientific_name: "#{fish["Genus"]} #{fish["Species"]}",
        red_list_status: fish["Red List status"],
        population_trend: fish["Population trend"],
        red_list_id: fish["Species ID"])
      species.update(species.parse_red_list)
      species.save
    end
  end

   def self.seed_wiki_order
    @orders = Order.where(image_name: nil)
    @orders.each do |ord|
      wiki_info = ord.parse_wiki_order
      unless wiki_info.nil?
        ord.update( wiki_info )
        ord.save
      end
    end
  end

  def self.seed_wiki_family
    @families = Family.all
    @families.each do |family|
      family.name = family.name.gsub(",", "").gsub(" ","_")
      family.save
      wiki_info = family.parse_wiki_family
      unless wiki_info.nil?
        family.update( wiki_info )
        family.save
      end
    end
  end

  def self.seed_genus_photos
    @genus = Genus.all
    @genus.each do |genus|
        genus.update( genus.get_genus_photos )
        genus.save
    end
  end

  def self.seed_image_names
    CSV.foreach('db/species29374.csv', :headers => true) do |row|
      @species = Species.find_by(scientific_name: row["scientific_name"])
      @species.update(
        wikitext: row["wikitext"],
        image_name: row["image_name"])
      @species.save
    end
  end

end

class BigDataParser

  def self.seed_kingdom_phylum
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: 1)
  end


  def self.seed_chlass
    CSV.foreach('chlasses123.csv', :headers => true) do |row|
      Chlass.create(phylum_id: 1, name: row["name"])
    end
  end

  def self.seed_order
    CSV.foreach('orders789.csv', :headers => true) do |row|
      Order.create(chlass_id: row["chlass_id"],
                   name: row["name"],
                   wikitext: row["wikitext"],
                   image_name: row["image_name"])
    end
  end

  def self.seed_family
    CSV.foreach('families456.csv', :headers => true) do |row|
      Family.create(order_id: row["order_id"],
                   name: row["name"],
                   wikitext: row["wikitext"],
                   image_name: row["image_name"])
    end
  end

  def self.seed_genus
    CSV.foreach('genus456.csv', :headers => true) do |row|
      Genus.create(
        family_id: row["family_id"],
        name: row["name"],
        wikitext: row["wikitext"],
        image_name: row["image_name"])
    end
  end

  def self.seed_species
    CSV.foreach('kingdom456.csv', :headers => true) do |row|
      Species.create(
        genus_id: row["genus_id"],
        common_name: row["common_name"],
        scientific_name: row["scientific_name"],
        red_list_status: row["red_list_status"],
        population_trend: row["population_trend"],
        red_list_id: row["SISRecID"],
        wikitext: row["wikitext"],
        image_name: row["image_name"],
        red_list_id: row["red_list_id"],
        range: row["range"],
        habitat: row["habitat"],
        major_threats: row["major_threats"])
    end
  end

  def self.shark_dot_all
    seed_kingdom_phylum
    seed_chlass
    seed_order
    seed_family
    seed_genus
    seed_species
  end

end

class Relinker
  def self.mammals
    count = 0
    CSV.foreach('Mammals_Higher_Taxonomy_8.csv', :headers => true) do |csv|
      if s = Species.find_by(scientific_name: "#{csv['Genus']} #{csv['Species']}")
        g = Genus.find_by(name: csv['Genus'])
        f = Family.find_by(name: csv['Family'])
        o = Order.find_by(name: csv['Order'])
        c = 1

        s.genus_id = g.id

        if f != g.family_id
          g.family_id = f.id
          g.save
        end

        if o != f.order_id
          f.order_id = o.id
          f.save
        end

        if c != o.chlass_id
          o.chlass_id = c.id
          o.save
        end
        count += 1
      end
    end
    puts "=" * 25
    puts "Updated #{count} Records"
  end

  def self.birds
    count = 0
    CSV.foreach('birds_proper.csv', :headers => true) do |csv|
      if s = Species.find_by(scientific_name: csv['Scientific name'])
        g = Genus.find_by(name: csv["Scientific name"].split(" ")[0])
        f = Family.find_by(name: csv['Family'])
        o = Order.find_by(name: csv['Order'])
        c = 5

        s.genus_id = g.id

        if f != g.family_id
          g.family_id = f.id
          g.save
        end

        if o != f.order_id
          f.order_id = o.id
          f.save
        end

        if c != o.chlass_id
          o.chlass_id = c.id
          o.save
        end
        count += 1
      end
    end
    puts "=" * 25
    puts "Updated #{count} Records"
  end

  def self.reptiles
    count = 0
    CSV.foreach('Reptiles_Higher_Taxonomy_8.csv', :headers => true) do |csv|
      if s = Species.find_by(scientific_name: "#{csv['Genus']} #{csv['Species']}")
        g = Genus.find_by(name: csv['Genus'])
        f = Family.find_by(name: csv['Family'])
        o = Order.find_by(name: csv['Order'])
        c = 2

        s.genus_id = g.id

        if f != g.family_id
          g.family_id = f.id
          g.save
        end

        if o != f.order_id
          f.order_id = o.id
          f.save
        end

        if c != o.chlass_id
          o.chlass_id = c.id
          o.save
        end
        count += 1
      end
    end
    puts "=" * 25
    puts "Updated #{count} Records"
  end

  def self.amphibians
    count = 0
    CSV.foreach('Amphibians_Higher_Taxonomy_8.csv', :headers => true) do |csv|
      if s = Species.find_by(scientific_name: "#{csv['Genus']} #{csv['Species']}")
        g = Genus.find_by(name: csv['Genus'])
        f = Family.find_by(name: csv['Family'])
        o = Order.find_by(name: csv['Order'])
        c = 3

        s.genus_id = g.id

        if f != g.family_id
          g.family_id = f.id
          g.save
        end

        if o != f.order_id
          f.order_id = o.id
          f.save
        end

        if c != o.chlass_id
          o.chlass_id = c.id
          o.save
        end
        count += 1
      end
    end
    puts "=" * 25
    puts "Updated #{count} Records"
  end

  def self.fishies
    count = 0
    CSV.foreach('MarineFish_Higher_Taxonomy_8.csv', :headers => true) do |csv|
      if s = Species.find_by(scientific_name: "#{csv['Genus']} #{csv['Species']}")
        g = Genus.find_by(name: csv['Genus'])
        f = Family.find_by(name: csv['Family'])
        o = Order.find_by(name: csv['Order'])
        c = 4

        s.genus_id = g.id

        if f != g.family_id
          g.family_id = f.id
          g.save
        end

        if o != f.order_id
          f.order_id = o.id
          f.save
        end

        if c != o.chlass_id
          o.chlass_id = c.id
          o.save
        end
        count += 1
      end
    end
    puts "=" * 25
    puts "Updated #{count} Records"
  end

  def self.fixBlankImages
    default_images = [
      "",
      "/image/lion-icon.png",
      "/image/lizard-icon.png",
      "/image/frog-icon.png",
      "/image/fish-icon.png",
      "/image/bird-icon.png"
    ]

    # http://localhost:9393/http:/images/default.jpg
    xclasses = Chlass.all
    xclasses.each do |xclass|
      xorders = Order.where(chlass_id: xclass.id)
      xorders.each do |xorder|
        if xorder.image_name == nil || xorder.image_name.include?("Status_iucn") || xorder.image_name == "none" || xorder.image_name.include?("tree-frog-logo.png")
          xorder.image_name = default_images[xclass.id]
          xorder.save
        end
        xfamilies = Family.where(order_id: xorder.id)
        xfamilies.each do |xfamily|
          if xfamily.image_name == nil || xfamily.image_name.include?("Status_iucn") || xfamily.image_name == "none" || xfamily.image_name.include?("tree-frog-logo.png")
            xfamily.image_name = xorder.image_name
            xfamily.save
          end
          xgenuses = Genus.where(family_id: xfamily.id)
          xgenuses.each do |xgenus|
            if xgenus.image_name == nil || xgenus.image_name.include?("Status_iucn") || xgenus.image_name.include?("tree-frog-logo.png")
              xgenus.image_name = xfamily.image_name
              xgenus.save
            end
            xspecieses = Species.where(genus_id: xgenus.id)
            xspecieses.each do |xspecies|
              if xspecies.image_name == nil || xspecies.image_name.include?("Status_iucn") || xspecies.image_name.include?("tree-frog-logo.png")
                xspecies.image_name = xgenus.image_name
                xspecies.save
              end
            end
          end
        end
      end
    end
  end
end


#=== use this guy to seed from CSVs =============#
# BigDataParser.shark_dot_all
# Chlass.all.destroy_all
# BigDataParser.seed_chlass
#================================================#

# === relinking taxonomy structure ===============
  # "Mammalia", 1,
  # "Reptilia", 2,
  # "Amphibia", 3,
  # "Osteichthyes", 4,
  # "Aves", 5


# === relinking taxonomy structure ===============

# Relinker.mammals
# Relinker.birds
Relinker.reptiles
Relinker.amphibians
Relinker.fishies
Relinker.fixBlankImages

#=Wont need to run these if the CSV seeding works==#
# Parser.seed_birds
# Parser.seed_mammals
# Parser.seed_reptiles
# Parser.seed_amphibians
# Parser.seed_marine_life
# Parser.seed_image_names
# Parser.seed_wiki_family
# Parser.seed_wiki_order
# Parser.seed_genus_photos

#================================================#
