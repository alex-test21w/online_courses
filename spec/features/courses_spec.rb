require 'rails_helper'

RSpec.feature 'Courses', type: :feature, js: true do
  let(:user) { create :user }

  before     { login_as(user) }

  feature 'Index Page' do
    context 'Check links' do
      let!(:course) { create_list :course, 2 }

      before { visit courses_path }

      scenario 'Show course' do
        click_on course.first.title

        expect(page).to have_content course.first.title
        expect(page.current_path).to eq course_path(course.first)
      end

      scenario 'Show participants' do
        click_on 'Participants', match: :first

        expect(page).to have_selector('h1', text: 'participants')
        expect(page.current_path).to eq course_participants_path(course.last)
      end

      scenario 'Show lessons' do
        click_on 'Lessons', match: :first

        expect(page).to have_selector('h1', text: 'Lessons')
        expect(page.current_path).to eq course_lessons_path(course.last)
      end
    end

    context 'Subscription' do
      let!(:course) { create_list :course, 2 }

      context 'Add subscription' do
        before { visit courses_path }

        specify do
          click_on 'Add subscription', match: :first

          expect(page).to have_css('.course-unsubscribe-button', match: :first, text: 'Unsubscription')
          expect(page).to_not have_css('.course-unsubscribe-button', match: :first, text: 'Add subscription')
          expect(page.current_path).to eq courses_path
        end

        context 'when email of user is blank' do
          before do
            user.email = ''
            user.save(validate: false)
          end

          specify do
            click_on 'Add subscription', match: :first

            expect(page).to have_css('h4', text: 'You should add email for continue')
          end

          context 'add email for user' do
            specify do
              click_on 'Add subscription', match: :first

              fill_in 'user[email]', with: 'email@email.com'

              click_on 'Save changes'

              expect(page).to have_css('p', text: 'Your email was successfully created')
              expect(page).to_not have_css('h4', text: 'You should add email for continue')
            end
          end
        end

        context 'when user was excluded from the course' do
          let!(:course_user) { create(:course_user, user: user, course: course.last, outcast: true) }

          scenario 'Attempt adding subscription' do
            click_on 'Add subscription', match: :first

            expect(page).to have_css('p', text: 'You was excluded from the course')
          end

          scenario 'Attempt go to lessons page' do
            click_on 'Lessons', match: :first

            expect(page).to have_css('p', text: 'You was excluded from the course')
          end
        end
      end

      context 'Unsubscribe' do
        let!(:course_user) { create(:course_user, user: user, course: course.last, subscription: true) }

        before { visit courses_path }

        specify do
          click_on 'Unsubscription', match: :first

          expect(page).to have_css('.course-subscription-button', match: :first, text: 'Add subscription', wait: 1)
          expect(page).to_not have_css('.course-unsubscribe-button', match: :first, text: 'Unsubscription')
        end
      end
    end
  end
end
