helpers do

    def wikiImage( search_string, css_class="thumb" )
    # method to get images, only use in views
    # USAGE: <%= wikiImage(search_subject, optional css class) %>
    search_string = search_string.split(' ').join('_')
    search_string = search_string.split('-').join('_').downcase
    url = "http://en.wikipedia.org/wiki/#{search_string}"
    p url

    begin
        doc = Nokogiri::HTML(open(url))
        img_link = doc.search('.infobox img')[0]['src']  # img source
    rescue
        img_link = "//upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Bobolink%2C_Mer_Bleue.jpg/800px-Bobolink%2C_Mer_Bleue.jpg"
    end
    return "<img src=http:#{img_link} class=#{css_class} />"
  end

  def red_list_image( search_string, css_class="thumb" )
    url = "http://www.iucnredlist.org/details/summary/56429/0"

    doc = Nokogiri::HTML(open(url))
    img_link = doc.search('#data_factsheet') # img source

    # return "<img src=http:#{img_link} class=#{css_class} />"
    puts "img_link: #{img_link}"
  end

end


