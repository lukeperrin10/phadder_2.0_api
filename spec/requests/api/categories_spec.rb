RSpec.describe "Api::Categories", type: :request do
  describe "GET /api/categories" do
    let!(:consulting) {create(:category, name: 'Consulting')}
    let!(:accounting) {create(:category, name: 'Accounting')}

    before {get '/api/categories'}
    it "responds with 200" do
      expect(response).to have_http_status :ok
    end

    it 'responds with the right amount of objects' do 
      expect(response_json.count).to eq 2
    end
  end
end
