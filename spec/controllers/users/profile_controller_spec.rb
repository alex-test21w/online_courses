require 'rails_helper'

RSpec.describe Users::ProfileController, type: :controller do
  let(:user) { create(:user, email: 'email@mail.com') }

  before { sign_in(user) }

  describe '#index' do
    let(:course_user) { create(:course_user, user: user, subscription: true) }
    let(:activity)    { create(:activity, recipient: user) }

    specify do
      expect(assigns(:courses)).to eq Course.last
      expect(assigns(:activities)).to eq Activity.last
    end
  end

  describe '#update' do
    context 'when success' do
      let(:params) { { user: { email: 'new@email.com' } } }

      before { put :update, params: params }

      it 'should update record and redirect to user profile' do
        expect(user.reload.email).to eq 'new@email.com'
        expect(response).to redirect_to users_profile_path
      end
    end

    context 'when failure' do
      let(:params) { { user: { email: '' } } }

      before { put :update, params: params }

      it 'should render form with invalid data' do
        expect(user.reload.email).to eq 'email@mail.com'
        expect(response).to render_template :edit
      end
    end
  end
end
