describe Search::Result do
  let(:source) { Search::GSMArenaHandheldsSource.new }
  let(:result) { Search::Result.new('Samsung Galaxy S8', source) }

  describe '#to_hash' do
    it 'correctly serializes an object' do
      expect(result.to_hash).to eq(name: 'Samsung Galaxy S8', source: :gsmarena_handhelds, details: {})
    end
  end
end
