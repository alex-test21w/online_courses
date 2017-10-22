require 'rails_helper'

RSpec.describe CreateAuthToken, type: :interactor do
  describe '.call' do
    subject(:context) { CreateAuthToken.call(params) }

    context 'when given valid credentials' do
      let(:user)   { create :user, email: 'example@email.com' }
      let(:access_token) { SecureRandom.hex(12) }
      let(:secret_key)   { SecureRandom.hex(12) }
      let(:params) { { service_name: 'twitter', access_token: access_token, secret_key: secret_key } }
      let(:token) { auth_token(user.id) }

      before { allow_any_instance_of(SocialServices::Twitter).to receive(:authenticate).and_return(token) }

      specify do
        expect(context).to be_a_success
      end

      it 'provides the user\'s secret token' do
        expect(context.auth_token).to eq token
      end
    end

    context 'when given invalid credentials' do
      let(:params) { { service_name: 'twitter', access_token: '', secret_key: '' } }

      specify do
        expect(context.error).to eq 'Please check the accuracy of the input parameters'
      end
    end
  end
end
