describe API::SearchController do
  describe 'GET index' do
    context 'when phrase meets the conditions' do
      before(:each) { get :index, phrase: %w( Apple iPhone Samsung Galaxy HTC ).sample }

      it 'responds with HTTP 200' do
        expect(response.status).to eq(200)
      end

      it 'responds with JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'responds with JSON having "result" in the root' do
        expect(JSON.parse(response.body).keys).to include('results')
      end

      it 'responds with well-formed search results' do
        JSON.parse(response.body)['results'].each do |result|
          expect(result.keys).to include('name', 'source', 'details')
        end
      end
    end

    context 'when phrase is blank' do
      it 'responds with HTTP 422' do
        get :index, phrase: ''
        expect(response.status).to eq(422)
      end
    end

    context 'when phrase is too short' do
      it 'responds with HTTP 422' do
        get :index, phrase: 'a'
        expect(response.status).to eq(422)
      end
    end

    context 'when phrase is too long' do
      it 'responds with HTTP 422' do
        get :index, phrase: 'a' * 999
        expect(response.status).to eq(422)
      end
    end
  end
end
