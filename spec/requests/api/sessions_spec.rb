# frozen_string_literal: true

RSpec.describe 'POST /api/auth/sign_in', type: :request do
  let(:user) { create(:user, role: 'service_provider') }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:end_user) { create(:user, email: 'end_user-1@random.com') }

  subject { response }

  describe 'valid credentials' do
    let(:expected_response) do
      {
        'data' => { 'id' => user.id,
                    'email' => user.email,
                    'provider' => 'email',
                    'uid' => user.email,
                    'role' => 'service_provider',
                    'service_provider_id' => nil,
                    'first_name' => nil,
                    'last_name' => nil,
                    'allow_password_change' => false,
                    'language_code' => 'en' }
      }
    end
    before do
      post '/api/auth/sign_in', params: { email: user.email,
                                          password: user.password },
                                headers: headers
    end
    it 'is expected to return user' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'as enduser' do # what is this?
    before do
      post '/api/auth/sign_in', params: { email: end_user.email,
                                          password: end_user.password },
                                headers: headers
    end
    it { is_expected.to have_http_status(:unauthorized) }

    it 'is expected to return error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'invalid password' do
    before do
      post '/api/auth/sign_in', params: { email: user.email,
                                          password: 'wrong_password' },
                                headers: headers
    end

    it { is_expected.to have_http_status(401) }

    it 'is expected to return error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'invalid email' do
    before do
      post '/api/auth/sign_in', params: { email: 'wrong@email.com',
                                          password: user.password },
                                headers: headers
    end

    it { is_expected.to have_http_status(401) }

    it 'is expected to return error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
end

RSpec.describe 'DELETE /api/auth/sign_out', type: :request do
  let(:user) { create(:user, role: 'service_provider') }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  subject { response }

  before do
    post '/api/auth/sign_in', params: { email: user.email,
                                        password: user.password },
                              headers: headers

    @headers = { 'access-token' => response.headers['access-token'],
                 uid: response.headers['uid'],
                 client: response.headers['client'],
                 HTTP_ACCEPT: 'application/json' }
  end

  it 'is expected to log out an authenticated user' do
    binding.pry
    delete '/api/auth/sign_out', headers: @headers
    expect(response_json['success']).to eq true
  end
end
