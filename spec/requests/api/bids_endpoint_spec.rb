# frozen_string_literal: true
RSpec.describe 'Api::BidsController', type: :request do
  describe 'POST  api/service_requests/:service_request_id/bids' do
    let(:user) { create(:user, email: 'whatever@hotmail.com') }
    let!(:service_provider) { create(:service_provider, users: [user]) }
    let(:service_request) { create(:service_request, state: 'new') }
    let(:credentials) { user.create_new_auth_token }
    let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'with valid data' do
      before do
        post '/api/service_requests/bids',
             params: {
               bid: {
                 service_request_id: service_request.id,
                 amount: '200',
                 note: 'We are happy to help you with the thing you need'
               }
             }, headers: headers
      end

      it 'returns :ok on valid request' do
        expect(response.status).to eq 200
      end
    end

    describe 'with invalid data (no amount)' do
      before do
        post '/api/service_requests/bids',
             params: {
               bid: {
                 service_request_id: service_request.id
               }
             }, headers: headers
      end

      it 'returns :unprocessable_entity on valid request' do
        expect(response.status).to eq 422
      end
    end
  end
end