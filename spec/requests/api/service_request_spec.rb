# frozen_string_literal: true

RSpec.describe 'Api::ServiceRequestsController', type: :request do
  let(:user) do
    create(:user,
           email: 'whatever@hotmail.com',
           role: :service_provider)
  end
  let(:category) { create(:category) }
  let!(:service_provider) do
    create(:service_provider,
           users: [user],
           categories: [category])
  end
  let!(:service_provider_address) do
    create(:address,
           city: 'Gothenburg',
           post_code: '42432',
           service_provider: service_provider)
  end
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:unouthorized_headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'GET api/service_requests' do
    let!(:service_requests_in_proximity) { 3.times { create(:service_request, location: '42465', categories: [category]) } }
    let!(:distant_service_requests) { 3.times { create(:service_request, location: '11330', categories: [category]) } }
    let!(:finalized_service_request) { create(:service_request, state: 'finalized') }

    describe 'as an authenticated user' do
      before do
        get '/api/service_requests', headers: headers
      end

      it 'should return a collection of service requests' do
        expect(response_json.count).to eq 3
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end
    end

    describe 'as an unauthenticated user' do
      before do
        get '/api/service_requests'
      end

      it 'should not return a collection of service requests' do
        expect(response_json['errors']).to eq ['You need to sign in or sign up before continuing.']
      end

      it 'returns 401' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'GET api/service_requests/:id' do
    let(:categroy_1) { create(:category, name: 'Construction') }
    let(:categroy_2) { create(:category, name: 'Renovation') }
    let!(:service_request) { create(:service_request, title: 'I need help', categories: [categroy_1, categroy_2]) }

    describe 'as an authenticated user' do
      before do
        get api_service_request_path(service_request), headers: headers
      end

      it 'returns the right instance of requested service request' do
        expect(response_json['id']).to eq service_request.id
      end

      it 'returns :ok' do
        expect(response.status).to eq 200
      end

      it 'returns the right title of requested service request' do
        expect(response_json['title']).to eq 'I need help'
      end

      it 'returns images of requested service request' do
        expect(response_json['images'].size).to eq 1
      end

      it 'returns categories of requested service request' do
        expect(response_json['categories'].size).to eq 2
      end
    end

    describe 'as an unauthenticated user' do
      before do
        get api_service_request_path(service_request), headers: unouthorized_headers
      end

      it 'returns an error message' do
        expect(response_json['errors']).to eq ['You need to sign in or sign up before continuing.']
      end

      it 'returns :unauthorized' do
        expect(response.status).to eq 401
      end
    end
  end
end