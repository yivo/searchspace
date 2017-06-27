describe Search::GSMArenaCriteria do
  describe '#to_query' do
    it 'generates well-formed query string for given source' do
      expect(Search::GSMArenaCriteria.new('Samsung Galaxy').to_query).to eq('sName=Samsung+Galaxy&sQuickSearch=yes')
    end
  end
end
