describe Search::GSMArenaHandheldsSource do
  let(:source) { Search::GSMArenaHandheldsSource.new }

  describe '#search_url' do
    it 'seems to be a valid URL' do
      expect(source.search_url).to match(/gsmarena\.com/)
    end
  end

  describe '#create_criteria' do
    it 'finds derived search criteria class' do
      expect(source.create_criteria { |klass| klass.new('iPhone') }).to be_instance_of(Search::GSMArenaHandheldsCriteria)
    end
  end

  describe '#create_result' do
    it 'provides basic search result if no better found' do
      expect(source.create_result { |klass| klass.new('iPhone 5', source) }).to be_instance_of(Search::Result)
    end
  end
end
