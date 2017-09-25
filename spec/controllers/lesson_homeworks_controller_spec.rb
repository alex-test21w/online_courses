require 'rails_helper'

RSpec.describe LessonHomeworksController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    let(:course) { create(:course) }
    let(:lesson) { create(:lesson, course_id: course.id) }

    context 'when is success' do
      let(:params) { { homework: { description: 'Description' }, lesson_id: lesson.id, course_id: course.id } }

      before { post :create, params: params }

      specify do
        expect(response).to redirect_to course_lesson_path(course_id: course.id, id: lesson.id)
        expect(flash[:success]).to match 'The homework was created'
      end
    end

    context 'when is failure' do
      let(:params) { { homework: { description: '' }, lesson_id: lesson.id, course_id: course.id } }

      before { post :create, params: params }

      specify do
        expect(response).to redirect_to course_lesson_path(course_id: course.id, id: lesson.id)
        expect(flash[:error]).to match 'Description can\'t be empty'
      end
    end
  end
end
