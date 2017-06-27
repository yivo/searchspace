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
end
