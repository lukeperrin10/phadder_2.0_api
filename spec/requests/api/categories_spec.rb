RSpec.describe "Api::Categories", type: :request do
  describe "GET /api/categories" do
    let!(:consulting) {create(:category, name: 'Consulting')}
    let!(:accounting) {create(:category, name: 'Accounting')}
    # let!(:consulting_translation) do
    #   Category::Translation.create!(category_id: consulting.id,
    #     locale: 'sv',
    #     name: 'Konsulting')
    # end


    # let!(:accounting_translation) do
    #   Category::Translation.create!(category_id: accounting.id,
    #     locale: 'sv',
    #     name: 'Bokföring')
    # end

    before {get '/api/categories'}
    it "responds with 200" do
      expect(response).to have_http_status :ok
    end

    it 'responds with the right amount of objects' do 
      expect(response_json.count).to eq 2
    end

    # it 'response include the swedish translation' do 
    #   expect(response_json.first['translations'].count).to eq 2
    # end
  end
end
