helpers do

    def wikiImage( search_string, css_class="thumb" )
    # method to get images, only use in views
    # USAGE: <%= wikiImage(search_subject, optional css class) %>
    url = "http://en.wikipedia.org/wiki/#{search_string.split(' ').join('_')}"
    doc = Nokogiri::HTML(open(url))
    img_link = doc.search('.infobox img')[0]['src']  # img source
    return "<img src=http:#{img_link} class=#{css_class} />"
  end

end


