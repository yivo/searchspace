describe Search::GSMArenaHandheldsResultsBuilder do
  let :html do
    <<-HTML
      <div id="review-body" class="section-body">
        <div class="makers">
          <ul>
            <li><a href="htc_one-5313.php"><img src="http://cdn2.gsmarena.com/vv/bigpic/htc-one-m7-new1.jpg" title="HTC One Android smartphone. Announced 2013, February. Features 3G, 4.7″ Super LCD3 capacitive touchscreen, 4 MP camera, Wi-Fi, GPS, Bluetooth."><strong><span>HTC<br>One</span></strong></a></li>
            <li><a href="htc_desire_816-6073.php"><img src="http://cdn2.gsmarena.com/vv/bigpic/htc-desire-8.jpg" title="HTC Desire 816 Android smartphone. Announced 2014, February. Features 3G, 5.5″ Super LCD2 capacitive touchscreen, 13 MP camera, Wi-Fi, GPS, Bluetooth."><strong><span>HTC<br>Desire 816</span></strong></a></li>
          </ul>
        </div>
      </div>
    HTML
  end

  let(:parsed_html) {Nokogiri::HTML.fragment(html) {|config| config.nonet.huge.nowarning.noerror}}
  let(:source) { Search::GSMArenaHandheldsSource.new }
  let(:results_builder) { Search::GSMArenaHandheldsResultsBuilder.new(source) }
  let(:results) { results_builder.build(parsed_html) }

  describe '#build' do
    it 'finds search results in HTML document' do
      expect(results.size).to eq(2)
      expect(results[0].name).to match(/HTC One/)
      expect(results[1].name).to match(/HTC Desire/)
    end
  end
end
