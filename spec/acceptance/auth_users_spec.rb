require 'acceptance_helper'
include AuthHelper

RSpec.resource 'Auth users', document: :v1 do
  let(:user)   { create :user, email: 'aa@aa.aa', password: '123321123' }
  let(:auth_token) { auth_token user.id }

  post '/api/v1/auth_users' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    parameter :email, 'User email', required: true
    parameter :password, 'User password', required: true

    let(:email)    { user.email }
    let(:password) { '123321123' }
    let(:raw_post) { params.to_json }

    example 'Authenticating user' do
      do_request

      expect(params).to eq({
        'email'    => 'aa@aa.aa',
        'password' => '123321123'
      })

      expect(status).to eq 201
      expect(response_body).to eq({
                                     auth_token: AuthToken.encode(user_id: user.id)
                                  }.to_json)
    end

    context 'with wrong params' do
      let(:password) { '' }

      example 'Authenticating user with invalid params' do
        do_request

        expect(status).to eq 406
        expect(response_body).to eq({
                                       error: { message: 'Invalid email or password' }
                                    }.to_json)
      end
    end

    context 'with wrong credentials' do
      let(:password) { 'email' }
      let(:password) { 'password' }

      example 'Authenticating user with invalid credentials' do
        do_request

        expect(status).to eq 401
        expect(response_body).to eq({
                                       'error': { 'message': 'Not Authenticated' }
                                    }.to_json)
      end
    end
  end
end
