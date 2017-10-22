require 'rails_helper'

RSpec.describe AuthUser, type: :interactor do
  describe '.call' do
    subject(:context) { AuthUser.call(params) }

    context 'when given valid credentials' do
      let(:user)   { create :user, email: 'example@email.com' }
      let(:params) { { email: 'example@email.com', password: '111111' } }
      let!(:token) { auth_token(user.id) }

      specify do
        expect(context).to be_a_success
      end

      it 'provides the user\'s secret token' do
        expect(context.token).to eq token
      end
    end

    context 'when given invalid credentials' do
      let(:params) { { email: 'example@email.com', password: '' } }

      specify do
        expect(context.error).to eq 'Invalid email or password'
      end
    end
  end
end
