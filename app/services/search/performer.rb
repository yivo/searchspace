class Search::Performer
  def perform(source, criteria)
    url         = URI.parse(source.search_url).tap { |u| u.query = criteria.to_query }
    response    = load_data(url)
    data_type   = response.headers['Content-Type'].to_s.split(';').first.squish
    raw_data    = response.body.to_s.encode('UTF-8')
    parsed_data = parse_data(raw_data, data_type)

    source.create_results_builder { |klass| klass.new(source) }.build(parsed_data)
  end

protected
  def load_data(url)
    Faraday.get(url).tap do |response|
      if response.status == 204 || !response.status.in?(200..299)
        raise Search::Error, "received #{response.status} HTTP status code"
      end
    end
  end

  def parse_data(raw_data, data_type)
    case data_type
      when 'text/json', 'application/json'
        JSON.parse(raw_data)
      when 'text/html'
        Nokogiri::HTML.fragment(raw_data) { |config| config.nonet.huge.nowarning.noerror }
      else
        raise Search::Error, "unsupported or invalid data type: #{data_type.inspect}"
    end
  end
end
