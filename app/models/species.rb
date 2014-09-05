class Species < ActiveRecord::Base
  belongs_to :genus

  validates :scientific_name, uniqueness: true

  # regexs
  P_START = /<p>/ # start paragraph tags
  P_END = /<\/p>/ # end paragraph tags
  A_START = /<a[\s\/=a-zA-Z0-9."]*>/ # start link tag
  A_END = /<\/a>/ # end link tag

  def parseWikipedia
    # Working
    # TODO On error, get Genus info instead

    url = "http://en.wikipedia.org/wiki/#{self.scientific_name.split(" ").join("_")}"
    p url
    doc = Nokogiri::HTML(open(url))
    img_link = doc.search('.infobox img')[0]['src']  # img source
    intro = (doc.search('p')[0]).to_s  # first paragraph
    intro.gsub!(P_START, '<div class="intro">')
    intro.gsub!(P_END, "</div>")
    intro.gsub!(A_START, "<em>")
    intro.gsub!(A_END, "</em>")
    {intro: intro, img: img_link}
  end

end
