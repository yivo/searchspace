describe Search::Source do
  describe 'descendants tracking' do
    before do
      class FooSource < Search::Source; end
      class BarSource < Search::Source; end
    end

    it 'knows what sources are available' do
      expect(Search::Source.descendants).to contain_exactly(FooSource, BarSource)
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
end
