require 'rails_helper'

RSpec.describe CourseParticipantSubscriptionsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    context 'when is success' do
      let(:course) { create(:course) }

      before { post :create, xhr: true, params: { course_id: course.id } }

      specify do
        expect(assigns(:participant).subscription).to eq(true)
        expect(response.code).to eq '200'
      end
    end

    context 'when is failure' do
      let!(:course_user) { create :course_user, user_id: user.id, course_id: course.id, outcast: true  }
      let(:course) { create :course, user_id: user.id }

      before { post :create, params: { course_id: course.id } }

      specify do
        expect(response).to redirect_to course_participants_path(course)
        expect(flash[:error]).to match 'You was excluded from the course'
      end
    end
  end
end
