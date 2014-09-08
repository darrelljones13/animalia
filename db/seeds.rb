require 'csv'

class Parser

  def self.seed_birds
    kingdom = Kingdom.create(name: "Animalia")
    phylum = Phylum.create(name: "Chordata", kingdom_id: Kingdom.last.id)
    chlass = Chlass.create(name: "Aves", phylum_id: Phylum.last.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      Order.create(name: bird["order"], chlass_id: Chlass.last.id)
      Family.create(name: bird["family"], order_id: Order.last.id)
      Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: Family.last.id)
      Species.create(
        genus_id: Genus.last.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
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

      Species.create(
        genus_id: Genus.last.id,
        common_name: mammal["Common names (Eng)"],
        scientific_name: "#{mammal["Genus"]} #{mammal["Species"]}",
        red_list_status: mammal["Red List status"],
        population_trend: mammal["Population trend"])
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
      puts "Trying to save #{reptile["Common names (Eng)"]}"
      Species.create!(
        genus_id: Genus.last.id,
        common_name: reptile["Common names (Eng)"],
        scientific_name: "#{reptile["Genus"]} #{reptile["Species"]}",
        red_list_status: reptile["Red List status"],
        population_trend: reptile["Population trend"])
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
      Species.create(
        genus_id: Genus.last.id,
        common_name: amphibian["Common names (Eng)"],
        scientific_name: "#{amphibian["Genus"]} #{amphibian["Species"]}",
        red_list_status: amphibian["Red List status"],
        population_trend: amphibian["Population trend"])
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
      Species.create(
        genus_id: Genus.last.id,
        common_name: fish["Common names (Eng)"],
        scientific_name: "#{fish["Genus"]} #{fish["Species"]}",
        red_list_status: fish["Red List status"],
        population_trend: fish["Population trend"])
    end
  end

  def self.seed_image_names
    CSV.foreach('species.csv', :headers => true) do |row|

      @species = Species.find(row["id"])
      @species.update(
        wikitext: row["wikitext"],
        image_name: row["image_name"])
      @species.save
    end
  end

end

Parser.seed_birds
Parser.seed_mammals
Parser.seed_reptiles
Parser.seed_amphibians
Parser.seed_marine_life
Parser.seed_image_names
