describe Search::Source do
  describe 'descendants tracking' do
    before do
      class FooSource < Search::Source; end
      class BarSource < Search::Source; end
    end

    it 'knows what sources are available' do
      expect(Search::Source.descendants).to include(FooSource, BarSource)
    end
  end

  describe 'name generation' do
    context 'when #name is called on a base class' do
      it 'does not generate anything' do
        expect(Search::Source.new.name).to be_nil
      end
    end

    context 'when #name is called on an derived class' do
      before { class EbayTabletsSource < Search::Source; end; EbayTabletsSource }
      it 'correctly generates name and returns symbol' do
        expect(EbayTabletsSource.new.name).to be(:ebay_tablets)
      end
    end

    before { class GitHubUsersSource < Search::Source; end; GitHubUsersSource }
    it 'correctly handles complex names with acronyms' do
      expect(GitHubUsersSource.new.name).to be(:github_users)
    end
  end

  describe '#search_url' do
    context 'when is not implemented' do
      it 'raises an exception' do
        expect { Search::Source.new.search_url }.to raise_error(MethodNotImplemented)
      end
    end
  end

  describe '#create_criteria' do
    it 'passes basic search criteria' do
      expect(Search::Source.new.create_criteria { |k| k.new('HTC') }).to be_instance_of(Search::Criteria)
    end
  end
end
