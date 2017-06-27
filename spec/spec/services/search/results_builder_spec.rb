describe Search::ResultsBuilder do
  let(:gsmarena_handhelds_source) { Search::GSMArenaHandheldsSource.new }
  let(:abstract_builder) { Search::ResultsBuilder.new(gsmarena_handhelds_source) }

  describe '#build' do
    it 'raises exception if is not implemented' do
      expect { abstract_builder.build([]) }.to raise_error(MethodNotImplemented)
    end
  end
end
