require 'acceptance_helper'
include AuthHelper

RSpec.resource 'Auth users through twitter', document: :v1 do
  let(:user)       { create :user, email: 'aa@aa.aa', password: '123321123' }
  let(:token)      { auth_token(user.id) }

  post '/api/v1/auth_tokens' do
    header 'Accept', 'application/json'

    parameter :service_name, 'service name', required: true
    parameter :access_token, 'access token', required: true
    parameter :secret_key,   'secret key',   required: true

    let(:service_name) { 'twitter' }
    let(:access_token) { SecureRandom.hex(12) }
    let(:secret_key)   { SecureRandom.hex(12) }

    before { allow_any_instance_of(Api::V1::AuthTokensController).to receive(:authenticate_through_social_networks).and_return(token) }

    example 'Authenticating user' do
      do_request

      expect(response_body).to eq({
                                     auth_token: token
                                  }.to_json)
    end


    context 'with wrong params' do
      let(:service_name) { '' }
      let(:access_token) { SecureRandom.hex(12) }

      example 'Authenticating user with invalid params' do
        do_request

        expect(status).to eq 406
        expect(response_body).to eq({
                                       error: { message: 'Invalid params' }
                                    }.to_json)
      end
    end

    context 'with wrong credentials' do
      let(:service_name) { 'twitter' }
      let(:access_token) { SecureRandom.hex(12) }
      let(:secret_key)   { SecureRandom.hex(12) }

      before { allow_any_instance_of(Api::V1::AuthTokensController).to receive(:authenticate_through_social_networks).and_return(nil) }

      example 'Authenticating with invalid credentials' do
        do_request

        expect(status).to eq 401
        expect(response_body).to eq({
                                       'error': { 'message': 'Not Authenticated' }
                                    }.to_json)
      end
    end
  end
end
