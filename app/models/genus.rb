class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.family.order.chlass.phylum.kingdom.name,
    "phylum" => self.family.order.chlass.phylum.name,
    "class" => self.family.order.chlass.name,
    "order" => self.family.order.name,
    "family" => self.family.name
    }
  end

  def parent_name
    "family"
  end

  def self
    "genus"
  end

  def parseWikipedia
    # Works
    # TODO refactor wikipedia parser
    begin
      url = "http://en.wikipedia.org/wiki/#{self.name.split(" ").join("_")}"
      doc = Nokogiri::HTML(open(url))
      # img_link = doc.search('.infobox img')[0]['src']  # img source
      # intro = (doc.search('p')[0]).to_s # description

      img_link = doc.search('.thumbinner img')[0]['src']
      intro = doc.search('p')[4].text
      intro.gsub!(P_START, '<div class="description">')
      intro.gsub!(P_END, "</div>")
      intro.gsub!(A_START, "<em>")
      intro.gsub!(A_END, "</em>")
      return {intro: intro, img: img_link}
    rescue OpenURI::HTTPError => ex
    end
    begin
      genus_url = "http://en.wikipedia.org/wiki/#{self.name.split(" ")[0]}"
      doc = Nokogiri::HTML(open(genus_url))
      img_link = doc.search('.infobox img')[0]['src'] # img source
      intro = "<div class='intro'>The #{self.scientific_name} does not have a Wikipedia.org entry.  <a href='#{url}' class='button'>Create one!</a></div>"
      {intro: intro, img: img_link}
    rescue
      img_link = "//upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Bobolink%2C_Mer_Bleue.jpg/800px-Bobolink%2C_Mer_Bleue.jpg"
      return {intro: '', img: img_link}
    end
  end

end
