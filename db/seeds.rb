require 'csv'

class Parser

  def self.seed_birds
    k = Kingdom.create!(name: "Animalia")
    p = Phylum.create!(name: "Chordata", kingdom_id: k.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      c = Chlass.create(name: "Aves", phylum_id: p.id)
      o = Order.create(name: bird["order"], chlass_id: c.id)
      f = Family.create(name: bird["family"], order_id: o.id)
      g = Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: f.id)
      Species.create(
        genus_id: g.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
    end
  end

  def self.seed_mammals
    k = Kingdom.create!(name: "Animalia")
    p = Phylum.create!(name: "Chordata", kingdom_id: k.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      c = Chlass.create(name: "Aves", phylum_id: p.id)
      o = Order.create(name: bird["order"], chlass_id: c.id)
      f = Family.create(name: bird["family"], order_id: o.id)
      g = Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: f.id)
      Species.create(
        genus_id: g.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
    end
  end

  def self.seed_reptiles
    k = Kingdom.create!(name: "Animalia")
    p = Phylum.create!(name: "Chordata", kingdom_id: k.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      c = Chlass.create(name: "Aves", phylum_id: p.id)
      o = Order.create(name: bird["order"], chlass_id: c.id)
      f = Family.create(name: bird["family"], order_id: o.id)
      g = Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: f.id)
      Species.create(
        genus_id: g.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
    end
  end

  def self.seed_amphibians
    k = Kingdom.create!(name: "Animalia")
    p = Phylum.create!(name: "Chordata", kingdom_id: k.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      c = Chlass.create(name: "Aves", phylum_id: p.id)
      o = Order.create(name: bird["order"], chlass_id: c.id)
      f = Family.create(name: bird["family"], order_id: o.id)
      g = Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: f.id)
      Species.create(
        genus_id: g.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
    end
  end

  def self.seed_marine_life
    k = Kingdom.create!(name: "Animalia")
    p = Phylum.create!(name: "Chordata", kingdom_id: k.id)

    CSV.foreach('db/birds.csv', :headers => true) do |bird|
      c = Chlass.create(name: "Aves", phylum_id: p.id)
      o = Order.create(name: bird["order"], chlass_id: c.id)
      f = Family.create(name: bird["family"], order_id: o.id)
      g = Genus.create(name: bird["scientific_name"].split(" ")[0], family_id: f.id)
      Species.create(
        genus_id: g.id,
        common_name: bird["common_name"],
        scientific_name: bird["scientific_name"],
        red_list_status: bird["red_list_cat"])
    end
  end

end

Parser.seed_birds
