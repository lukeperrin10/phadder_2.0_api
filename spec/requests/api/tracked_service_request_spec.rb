# frozen_string_literal: true

RSpec.describe 'Api::TrackedServiceRequestsController', type: :request do
  let(:user) { create(:user, email: 'whatever@hotmail.com') }
  let!(:service_provider) { create(:service_provider, users: [user]) }
  let(:service_request) { create(:service_request, state: 'new') }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'GET /api/tracked_service_request' do
    before do
      3.times { create(:service_request, state: 'new') }
      3.times do |i|
        create(:tracked_service_request, creator: user, service_provider: service_provider, service_request: ServiceRequest.all[i])
      end
      get api_tracked_service_requests_path, headers: headers
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'should return a collection of tracked service requests' do
      expect(response_json.count).to eq 3
    end
  end

  describe 'POST api/tracked_service_requests' do
    it 'returns :ok on valid request' do
      post api_tracked_service_requests_path, params: { service_request_id: service_request.id }, headers: headers
      expect(response.status).to eq 200
    end

    it 'returns :unprocessable_entity on invalid request' do
      post api_tracked_service_requests_path, headers: headers
      expect(response.status).to eq 422
    end
  end
end