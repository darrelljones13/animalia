class Species < ActiveRecord::Base
  belongs_to :genus

  validates :scientific_name, uniqueness: true

  # REGEXS FOR DOC PARSE/REPLACE
  P_START = /<p>/ # start paragraph tags
  P_END = /<\/p>/ # end paragraph tags
  A_START = /<a href=".*">/ # start link tag
  A_END = /<\/a>/ # end link tag

  def parseWikipedia
    # Works
    # TODO refactor wikipedia parser
    begin
      url = "http://en.wikipedia.org/wiki/#{self.scientific_name.split(" ").join("_")}"
      doc = Nokogiri::HTML(open(url))
      img_link = doc.search('.infobox img')[0]['src']  # img source
      intro = (doc.search('p')[0]).to_s # description
      intro.gsub!(P_START, '<div class="intro">')
      intro.gsub!(P_END, "</div>")
      intro.gsub!(A_START, "<em>")
      intro.gsub!(A_END, "</em>")
      print intro
      {intro: intro, img: img_link}
    rescue OpenURI::HTTPError => ex
      genus_url = "http://en.wikipedia.org/wiki/#{self.scientific_name.split(" ")[0]}"
      doc = Nokogiri::HTML(open(genus_url))
      img_link = doc.search('.infobox img')[0]['src']  # img source
      intro = '<div class="intro">The #{self.scientific_name} does not have a Wikipedia.org entry.  <a href="#{url}" class="button">Create one!</a></div>'
      {intro: intro, img: img_link}
    end
  end

  def redListStatus
    # TODO convert DB 2 character status code to readable string
    status_hash = { EX: "Extinct", EW: "Extinct in the Wild", CR: "Critically Endangered", EN: "Endangered", VU: "Vulnerable", NT: "Near Threatened", LC: "Least Concern", DD: "Data Deficient" }
    status_hash[self.red_list_status.to_sym]
  end

  def taxonomy
    {
    "kingdom" => self.genus.family.order.chlass.phylum.kingdom.name,
    "phylum" => self.genus.family.order.chlass.phylum.name,
    "class" => self.genus.family.order.chlass.name,
    "order" => self.genus.family.order.name,
    "family" => self.genus.family.name,
    "genus" => self.genus.name
    }
  end

end
