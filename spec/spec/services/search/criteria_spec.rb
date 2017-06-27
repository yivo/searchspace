describe Search::Criteria do
  def criteria(phrase)
    Search::Criteria.new(phrase)
  end

  let :bad_descendant do
    class SearchCriteriaDescendant < Search::Criteria
    end
    SearchCriteriaDescendant
  end

  let :good_descendant do
    class SearchCriteriaDescendant < Search::Criteria
      def to_hash
        { q: @phrase }
      end
    end
    SearchCriteriaDescendant
  end

  context 'when phrase has at least two chars' do
    it 'is applicable' do
      expect(criteria('ap').applicable?).to be_truthy
    end
  end

  context 'when phrase is blank' do
    it 'is not applicable' do
      expect(criteria(' ').applicable?).to be_falsey
    end
  end

  context 'when descendant did not implement #to_hash' do
    it 'raises an error' do
      expect { bad_descendant.new('apple').to_hash }.to raise_error MethodNotImplemented
    end
  end

  context 'when descendant did implement #to_hash' do
    it 'does not raise an error' do
      expect { good_descendant.new('apple').to_hash }.not_to raise_error
    end
  end
end
