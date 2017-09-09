require 'rails_helper'

RSpec.describe Users::LessonsController, type: :controller do
  let(:user) { create(:user) }
  let!(:lesson) { create(:lesson, title: 'Init title', course: course ) }
  let(:course) { create(:course, user_id: user.id) }

  before { sign_in(user) }

  describe '#index' do
    before { get :index, params: { course_id: course.id } }

    specify do
      expect(assigns(:lessons)).to match_array [lesson]
    end
  end

  describe '#new' do
    before { get :new, params: { course_id: course.id } }

    specify do
      expect(assigns(:lesson)).to be_a_new(Lesson)
    end
  end

  describe '#create' do
    context 'when is success' do
      let(:params) do
        {
          lesson: {
            title: 'title',
            position: 'position',
            descriprion: 'descriprion',
            picture: 'picture',
            synopsis: 'synopsis',
            homework: 'homework'
          },
          course_id: course.id
        }
      end

      before { post :create, params: params }

      it 'should redirect to lessons list' do
        expect(response).to redirect_to(users_course_lessons_path(course))
        expect(flash[:success]).to match 'Lesson was successfully created.'
      end
    end

    context 'when is failure' do
      let(:params) { { lesson: { title: '' }, course_id: course.id } }

      before { post :create, params: params }

      it 'render form with invalid data' do
        expect(assigns(:lesson)).to be_an_instance_of Lesson
        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    before { get :edit, params: { id: lesson.id, course_id: course.id } }

    specify do
      expect(assigns(:lesson)).to eq lesson
    end
  end

  describe '#update' do
    context 'when is success' do
      let(:params) { { title: 'New title' } }

      before { put :update, params: { id: lesson.id, lesson: params, course_id: course.id } }

      it 'should update record and redirect to lessons list' do
        expect(lesson.reload.title).to eq 'New title'
        expect(response).to redirect_to(users_course_lessons_path(course))
        expect(assigns(:lesson)).to be_an_instance_of Lesson
        expect(flash[:success]).to match 'Lesson was successfully updated.'
      end
    end

    context 'when is failure' do
      let(:params) { { title: '' } }

      before { put :update, params: { id: lesson.id, lesson: params, course_id: course.id } }

      it 'should render form with invalid data' do
        expect(lesson.reload.title).to eq 'Init title'
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    it 'should destroy record' do
      expect{ delete :destroy, params: { id: lesson.id, course_id: course.id } }.to change(Lesson, :count).by(-1)
      expect(response).to redirect_to(users_course_lessons_path(course))
    end
  end
end
