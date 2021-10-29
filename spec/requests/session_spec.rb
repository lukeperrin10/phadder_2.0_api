RSpec.describe 'POST /api/auth/sign_in', type: :request do
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      'data' => {
        'id' => user.id,
        'uid' => user.email,
        'email' => user.email,
        'provider' => 'email',
        'allow_password_change' => false,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'role' => user.role,
        'service_provider_id' => nil
      }
    }
  end

  describe 'with valid credentials' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: user.password
           }
    end

    it 'is expected to respond with a status 200' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the expected response' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'with invalid password' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: 'wrong_password'
           }
    end

    it 'is expected to responsd with a 401 status' do
      expect(response).to have_http_status 401
    end

    it 'is expected to return an error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
end
