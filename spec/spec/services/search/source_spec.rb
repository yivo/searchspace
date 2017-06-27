describe Search::Source do
  before do
    class FooSource < Search::Source; end
    class BarSource < Search::Source; end
  end

  describe 'descendants tracking' do
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
    it 'raises an exception if no criteria defined' do
      expect { FooSource.new.create_criteria }.to raise_error(NameError)
    end
  end

  describe '#create_results_builder' do
    it 'raises an exception if no results builder defined' do
      expect { FooSource.new.create_results_builder }.to raise_error(NameError)
    end
  end
end
