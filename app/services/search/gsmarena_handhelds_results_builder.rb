class Search::GSMArenaHandheldsResultsBuilder < Search::ResultsBuilder
  def build(doc)
    doc.css('#review-body ul li').map do |el|

      # Transform <br> into new lines.
      el.css('br').each { |br| br.replace("\n") }

      @source.create_result do |klass|
        name      = el.text.squish
        page_url  = URI.join('http://www.gsmarena.com/results.php3', el.css('a')[0]['href']).to_s
        image_url = el.css('img')[0]['src']
        klass.new(name, @source, page_url: page_url, image_url: image_url)
      end
    end
  end
end
