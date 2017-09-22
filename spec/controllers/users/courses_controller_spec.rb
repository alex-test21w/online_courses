require 'rails_helper'

RSpec.describe Users::CoursesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let!(:course) { create :course, user: user }

    before { get :index }

    specify do
      expect(assigns(:courses)).to match_array [course]
    end
  end

  describe '#new' do
    before { get :new }

    specify do
      expect(assigns(:course)).to be_a_new(Course)
    end
  end

  describe '#create' do
    context 'when success' do
      let(:params) { { course: { title: 'title', picture: fixture_file_upload('pixel.png', 'image/png') } } }

      before { post :create, params: params }

      it 'should redirect to courses list' do
        expect(response).to redirect_to(users_courses_path)
      end
    end

    context 'when failure' do
      let(:params) { { course: { title: '' } } }

      before { post :create, params: params }

      it 'render form with invalid data' do
        expect(assigns(:course)).to be_an_instance_of Course
        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    let(:course) { create :course, user: user }

    before { get :edit, params: { id: course.id } }

    specify do
      expect(assigns(:course)).to eq course
    end
  end

  describe '#update' do
    let!(:course) { create :course, title: 'Title', user: user }

    context 'when success' do
      let(:params) { { title: 'New title' } }

      before { put :update, params: { id: course.id, course: params } }

      it 'should update record and redirect to courses list' do
        expect(course.reload.title).to eq 'New title'
        expect(response).to redirect_to(users_courses_path)
        expect(assigns(:course)).to be_an_instance_of Course
      end
    end

    context 'when failure' do
      let(:params) { { title: '' } }

      before { put :update, params: { id: course.id, course: params } }

      it 'should render form with invalid data' do
        expect(course.reload.title).to eq 'Title'
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    let!(:course) { create :course, user: user }

    it 'should destroy record' do
      expect { delete :destroy, params: { id: course.id } }.to change(Course, :count).by(-1)
      expect(response).to redirect_to(users_courses_path)
    end
  end
end
