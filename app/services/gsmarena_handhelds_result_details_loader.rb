# http://www.gsmarena.com/htc_one-5313.php
class GSMArenaHandheldsResultDetailsLoader
  def load(url)
    response  = Faraday.get(url)
    document  = Nokogiri::HTML.fragment(response.body) { |config| config.nonet.huge.nowarning.noerror }
    root_el   = document.at_css('#specs-list')
    table_els = root_el&.css('table') || []

    {
      specs: table_els.each_with_object([]) { |table_el, memo| iteratee_categories(table_el, memo) }
    }
  end

private
  def iteratee_categories(table_el, categories)
    categories << {
      name: table_el.at_css('th')&.text&.squish,
      data: table_el.css('tr').each_with_object([]) { |tr_el, memo| iteratee_category_specs(tr_el, memo) }
    }
  end

  def iteratee_category_specs(tr_el, memo)
    td_els = tr_el.css('td')
    return unless td_els.size == 2

    # Transform <br> into new lines.
    tr_el.css('br').each { |br| br.replace("\n") }

    name, value = td_els.map(&:text)

    memo << { name: name.strip, value: value.strip }
  end
end
