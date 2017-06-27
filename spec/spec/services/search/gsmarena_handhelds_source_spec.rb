describe Search::GSMArenaHandheldsSource do
  describe '#search_url' do
    it 'seems to be a valid URL' do
      expect(Search::GSMArenaHandheldsSource.new.search_url).to match(/gsmarena\.com/)
    end
  end
end
