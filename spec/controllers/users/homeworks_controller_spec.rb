require 'rails_helper'

RSpec.describe Users::HomeworksController, type: :controller do
  let(:user)    { create(:user) }
  let!(:lesson) { create :lesson, course: course }
  let!(:course) { create :course, user: user }

  before { sign_in(user) }

  describe '#index' do
    let!(:homework) { create_list :homework, 2, lesson: lesson }
    let(:params)    { { course_id: course, lesson_id: lesson } }

    before { get :index, params: params }

    specify do
      expect(assigns(:homeworks)).to match_array homework
    end
  end

  describe '#update' do
    let!(:params) { { id: homework, course_id: course, lesson_id: lesson } }

    context 'when success' do
      context 'when state is approved' do
        let!(:homework) { create :homework, lesson: lesson, state: 'rejected' }

        before { put :update, xhr: true, params: params.merge!({ state: 'approved' }) }

        specify do
          expect(homework.reload.state).to eq 'approved'
          expect(response).to have_http_status(200)
        end
      end

      context 'when state is rejected' do
        let!(:homework) { create :homework, lesson: lesson, state: 'approved' }

        before { put :update, xhr: true, params: params.merge!({ state: 'rejected' }) }

        specify do
          expect(homework.reload.state).to eq 'rejected'
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'when failure' do
      let!(:homework) { create :homework, lesson: lesson, state: 'approved' }

      before { put :update, xhr: true, params: params.merge!({ state: 'incorrect' }) }

      it 'when state is incorrect' do
        expect(flash[:error]).to match "You can't set #{params[:state]} state"
      end
    end
  end
end
