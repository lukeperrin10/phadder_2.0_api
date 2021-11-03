RSpec.describe 'Api::ServiceRequestsController', type: :request do
  let(:user) { create(:user, role: 'end_user') }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:category) { create(:category) }
  let(:image) do
    File.read(fixture_path + '/text_image.txt')
  end

  describe 'POST api/service_request' do
    describe 'successfully' do
      before do
        post '/api/service_requests', params: {
          images: [
            image
          ],
          title: 'Need help with cleaning',
          details: 'Lorum ipsum',
          budget: '',
          time_frame: '',
          location: '424 32',
          category_ids: [
            category.id
          ]
        },
                                      headers: headers
      end

      it 'returns correct response' do
        expect(response_json['message']).to eq 'Your request was successfully submitted!'
      end

      it 'returns success message' do
        expect(response.status).to eq 200
      end

      it 'attaches the uploaded image' do
        service_request = ServiceRequest.last
        expect(service_request.images.attached?).to eq true
      end
    end
  end
end
