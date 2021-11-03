# frozen_string_literal: true

RSpec.describe 'Api::UsersController', type: :request do
  let!(:service_provider) { create(:service_provider) }
  let(:user) do
    create(:user, service_provider_id: service_provider.id,
                  first_name: 'John',
                  last_name: 'Doe')
  end
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:unouthorized_headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'GET /api/user' do
    describe 'as an authenticated user' do
      before do
        get api_user_path(user), headers: headers
      end

      it 'returns the right instance of user requested' do
        expect(response_json['id']).to eq user.id
      end

      it 'returns the right display name' do
        expect(response_json['display_name']).to eq user.display_name
      end

      it 'returns an avatar for the user' do
        expect(response_json['avatar'].size).to_not eq nil
      end

      it 'returns right service provider id of requested user' do
        expect(response_json['service_provider']['id']).to eq service_provider.id
      end

      it 'returns right service provider name of requested user' do
        expect(response_json['service_provider']['name']).to eq service_provider.name
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end
    end

    describe 'as an unauthenticated user' do
      before do
        get api_user_path(user), headers: unouthorized_headers
      end

      it 'returns an error message' do
        expect(response_json['errors']).to eq ['You need to sign in or sign up before continuing.']
      end

      it 'returns 401' do
        expect(response.status).to eq 401
      end
    end
  end
end