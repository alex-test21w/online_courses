require 'rails_helper'

RSpec.describe CourseSubscriptionsController, type: :controller do
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
      let!(:course_user) { create :course_user, user_id: user.id, course_id: course.id, outcast: true }
      let(:course) { create :course, user_id: user.id }

      before { post :create, params: { course_id: course.id } }

      specify do
        expect(response).to redirect_to courses_path
        expect(flash[:error]).to match 'You was excluded from the course'
      end
    end

    context 'when the user does not have an email address' do
      let!(:user) { create :user, :user_skip_validate, email: '' }
      let(:course) { create(:course) }

      context 'when query is ajax' do
        before { post :create, xhr: true, params: { course_id: course.id } }

        specify do
          expect(response).to render_template(partial: 'course_subscriptions/_missing_email')
        end
      end

      context 'create email' do
        context 'when email param is present' do
          context 'when is success' do
            let(:params) { { user: { email: 'user@email.com' }, course_id: course.id } }

            before { post :create, params: params }

            specify do
              expect(response).to redirect_to courses_path
              expect(flash[:success]).to match 'Your email was successfully created'
            end
          end

          context 'when email is incorrect' do
            let(:params) { { user: { email: 'user@email' }, course_id: course.id } }

            before { post :create, params: params }

            specify do
              expect(response).to redirect_to courses_path
              expect(flash[:error]).to match user.errors.full_messages.first
            end
          end
        end

        context 'when email param is not present' do
          let(:params) { { user: { email: '' }, course_id: course.id } }

          before { post :create, params: params }

          specify do
            expect(response).to redirect_to courses_path
            expect(flash[:error]).to match 'Your email cant be empty'
          end
        end
      end
    end
  end
end
