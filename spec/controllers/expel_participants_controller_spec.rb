require 'rails_helper'

RSpec.describe ExpelParticipantsController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    context 'when is success' do
      let!(:course_user) { create :course_user, course_id: course.id, user_id: user.id, outcast: false }
      let(:course) { create :course, user_id: user.id }

      before { post :create, xhr: true, params: { user_id: user.id, course_id: course.id } }

      specify do
        expect(course_user.reload.outcast).to eq(true)
        expect(response.code).to eq '200'
      end
    end

    context 'when is failure' do
      let(:user_2) { create :user }
      let(:course) { create(:course, user: user_2) }

      before { post :create, params: { course_id: course.id } }

      specify do
        expect(response).to redirect_to course_participants_path(course)
        expect(flash[:error]).to match "You aren't the creator of the course"
      end
    end
  end
end
