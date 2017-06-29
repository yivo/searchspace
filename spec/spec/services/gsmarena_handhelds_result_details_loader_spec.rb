describe GSMArenaHandheldsResultDetailsLoader do
  let(:loader) { GSMArenaHandheldsResultDetailsLoader.new }

  context 'gsmarena.com URL' do
    it 'correctly loads and parses specs' do
      loader.load('http://www.gsmarena.com/htc_one-5313.php').tap do |loaded|
        expect(loaded.keys).to include(:specs)
        expect(loaded[:specs].sample.keys).to include(:name, :data)
      end
    end
  end

  context 'invalid URL' do
    it 'loads data and does not parse specs' do
      loader.load('https://google.com').tap do |loaded|
        expect(loaded.keys).to include(:specs)
        expect(loaded[:specs].empty?).to be_truthy
      end
    end
  end
end
