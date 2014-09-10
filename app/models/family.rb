class Family < ActiveRecord::Base
  belongs_to :order
  has_many :genus
  has_many :species, through: :genus

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.order.chlass.phylum.kingdom.name,
    "phylum" => self.order.chlass.phylum.name,
    "class" => self.order.chlass.name,
    "order" => self.order.name
    }
  end

  def parent_name
    "order"
  end

  def self
    "family"
  end

  # REGEXS FOR DOC PARSE/REPLACE
  P_START = /<p>/ # start paragraph tags
  P_END = /<\/p>/ # end paragraph tags
  A_START = /<a href=".*">/ # start link tag
  A_END = /<\/a>/ # end link tag

  def parse_wiki_family
    begin
      url = "http://en.wikipedia.org/wiki/#{self.name.downcase}"
      doc = Nokogiri::HTML(open(url))

      img_link = doc.search('.infobox img')[0]['src']  # img source
      intro = (doc.search('p')[0]).to_s # description
      intro.gsub!(P_START, '<div class="intro">')
      intro.gsub!(P_END, "</div>")
      intro.gsub!(A_START, "<em>")
      intro.gsub!(A_END, "</em>")
      return {wikitext: intro, image_name: img_link}
    rescue OpenURI::HTTPError => ex
      {wikitext: "Unknown"}
    end
  end

end

begin
  
rescue Exception => e
  
end
