describe Search do
  describe '.sources' do
    it 'lists all available search sources' do
      expect(Search.sources.map(&:class)).to include(Search::GSMArenaHandheldsSource)
    end
  end
end
