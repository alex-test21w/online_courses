require 'rails_helper'

RSpec.describe CourseLessonsController, type: :controller do
  let(:user)   { create(:user) }
  let(:lesson) { create(:lesson, course: course) }
  let(:course) { create(:course, user_id: user.id) }

  before { sign_in(user) }

  describe '#index' do
    context 'when is success' do
      before { get :index, params: { course_id: course.id } }

      specify do
        expect(assigns(:lessons)).to match_array lesson
      end
    end

    context 'when is failure' do
      let(:course_2) { create(:course) }
      let!(:course_users) { create(:course_user, user_id: user.id, course_id: course_2.id, outcast: true) }

      before { get :index, params: { course_id: course_2.id } }

      specify do
        expect(response).to redirect_to(courses_path)
        expect(flash[:error]).to match 'You was excluded from the course'
      end
    end
  end

  describe '#show' do
    context 'when is success' do
      let!(:course_user) { create(:course_user, user_id: user.id, course_id: course.id, subscription: true) }

      before { get :show, params: { id: lesson.id, course_id: course.id } }

      specify do
        expect(assigns(:lesson)).to eq(lesson)
      end
    end

    context 'when is failure' do
      let(:course_2)      { create(:course) }
      let!(:lesson_2)     { create(:lesson, course: course_2) }
      let!(:course_users) { create(:course_user, user_id: user.id, course_id: course_2.id, outcast: true) }

      before { get :show, params: { id: lesson_2.id, course_id: course_2.id } }

      specify do
        expect(response).to redirect_to(courses_path)
        expect(flash[:error]).to match 'You was excluded from the course'
      end
    end
  end
end
