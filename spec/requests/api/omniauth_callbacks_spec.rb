# frozen_string_literal: true
RSpec.describe 'User Session', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'OmniAuth' do
    describe 'Authorized' do
      before do
        create(:user,
               first_name: 'Thomas',
               last_name: 'Ochman',
               email: 'thomas@craftacademy.se',
               password: 'password',
               role: 'service_provider',
               provider: 'facebook',
               uid: '10205522242159630')
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(OmniAuthFixtures.facebook_response)
      end
      context 'Facebook' do
        let(:params) { { omniauth_window_type: 'newWindow' } }
        let(:request) do
          lambda do
            get('/api/auth/facebook/',
                params: params,
                headers: headers)
            follow_redirect! until response.status == 200
          end
        end

        let(:bad_request) do
          lambda do
            get('/api/auth/facebook/',
                params: params,
                headers: headers)
            # follow_redirect! until response.status == 200
          end
        end

        it 'allows user to register with valid authorization' do
          # Uses default mock, set in support/oauth.rb
          request.call
          expect(response.code).to eq '200'
        end

        it 'fails to register user with invalid authorization' do
          OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
          expect { bad_request.call }.to change(User, :count).by(0)
        end
      end
    end
  end

  describe 'End user not allowed' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(OmniAuthFixtures.end_user_facebook_response)
    end

    context 'Facebook' do
      let(:params) { { omniauth_window_type: 'newWindow' } }
      let(:request) do
        lambda do
          get('/api/auth/facebook/',
              params: params,
              headers: headers)
          follow_redirect! until response.status == 200
        end
      end

      # it 'denies end user' do
      #   expect { request.call }.to_not change(User, :count)
      # end

      it 'allows end user' do
        expect { request.call }.to change(User, :count)
      end
    end
  end
end
