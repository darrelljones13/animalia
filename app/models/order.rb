class Order < ActiveRecord::Base
  belongs_to :chlass
  has_many :families
  has_many :genus, through: :family

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.chlass.phylum.kingdom.name,
    "phylum" => self.chlass.phylum.name,
    "class" => self.chlass.name
    }
  end

  def parent_name
    "class"
  end

  def self
    "order"
  end

  # REGEXS FOR DOC PARSE/REPLACE
  P_START = /<p>/ # start paragraph tags
  P_END = /<\/p>/ # end paragraph tags
  A_START = /<a href=".*">/ # start link tag
  A_END = /<\/a>/ # end link tag

  def parse_wiki_order
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
    end
  end

end
