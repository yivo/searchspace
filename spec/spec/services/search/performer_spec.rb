describe Search::Performer do
  context 'GSMArenaHandhelds, returning HTML data' do
    let(:source) { Search::GSMArenaHandheldsSource.new }
    let(:criteria) { Search::GSMArenaHandheldsCriteria.new('Meizu') }
    let(:performer) { Search::Performer.new }

    it 'loads results with all necessary data' do
      performer.perform(source, criteria).tap do |results|
        expect(results.size).to be > 0
        results.each do |result|
          expect(result.name).to match(/Meizu/)
          expect(result.source).to be source
          expect(result.details.keys).to include(:page_url, :image_url)
        end
      end
    end
  end
end
