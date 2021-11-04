# frozen_string_literal: true

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user, role: 'service_provider') }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:end_user) { create(:user, email: 'end_user-1@random.com') }

  context 'POST /api/auth/sign_in' do
    it 'valid credentials returns user' do
      post '/api/auth/sign_in', params: { email: user.email,
                                          password: user.password },
                                headers: headers

      expected_response = {
        'data' => { 'id' => user.id,
                    'email' => user.email,
                    'provider' => 'email',
                    'uid' => user.email,
                    'role' => 'service_provider',
                    'service_provider_id' => nil,
                    'first_name' => nil,
                    'last_name' => nil,
                    'language_code' => 'en' }
      }
      expect(response_json).to eq expected_response
    end

    it 'invalid password returns error message' do
      post '/api/auth/sign_in', params: { email: user.email,
                                          password: 'wrong_password' },
                                headers: headers

      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      expect(response.status).to eq 401
    end

    it 'invalid email returns error message' do
      post '/api/auth/sign_in', params: { email: 'wrong@email.com',
                                          password: user.password },
                                headers: headers

      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      expect(response.status).to eq 401
    end

    it 'end user not allowed to login' do
      post '/api/auth/sign_in', params: { email: end_user.email,
                                          password: end_user.password },
                                headers: headers

      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      expect(response.status).to eq 401
    end
  end

  context 'DELETE /api/auth/sign_out' do
    before do
      post '/api/auth/sign_in', params: { email: user.email,
                                          password: user.password },
                                headers: headers

      @headers = { 'access-token' => response.headers['access-token'],
                   uid: response.headers['uid'],
                   client: response.headers['client'],
                   HTTP_ACCEPT: 'application/json' }
    end

    it 'logs out a logged in user' do
      delete '/api/auth/sign_out', headers: @headers
      expect(response_json['success']).to eq true
    end
  end
end