require 'rails_helper'

RSpec.feature 'Course lessons', type: :feature do
  let(:user) { create :user }
  let!(:course) { create :course, lessons: create_list(:lesson, 2) }

  before     { login_as(user) }

  feature 'Lesson index page' do
    context 'when user is not outcast' do
      let!(:course_user) { create :course_user, user: user, course: course, subscription: true, outcast: false }

      before { visit course_lessons_path(course) }

      scenario 'View lesson' do
        click_on 'View lesson', match: :first

        expect(page).to have_content('Lesson')
        expect(page).to have_content(Lesson.last.title)
      end
    end

    context 'when user is outcast' do
      let!(:course_user) { create :course_user, user: user, course: course, subscription: true, outcast: true }

      before { visit course_lessons_path(course) }

      scenario 'View lesson' do
        expect(page).to_not have_content('View lesson')
      end
    end
  end

  feature 'Lesson show page', js: true do
    let!(:course_user) { create :course_user, user: user, course: course, subscription: true, outcast: false }

    context 'Deliver homework' do
      before { visit course_lesson_path(course, Lesson.last) }

      scenario 'when is successful' do
        click_on 'Deliver homework'

        fill_in 'homework[description]', with: 'New description'

        click_on 'Save changes'

        expect(page).to have_css('p', match: :first, text: 'The homework was created')
        expect(page.current_path).to eq course_lesson_path(course, Lesson.last)
      end

      scenario 'when is failure' do
        click_on 'Deliver homework'

        fill_in 'homework[description]', with: ''

        click_on 'Save changes'

        expect(page).to have_css('p', match: :first, text: 'Description can\'t be empty')
      end
    end

    context 'Comments' do
      context 'add comment' do
        before { visit course_lesson_path(course, Lesson.last) }

        scenario 'when successful' do
          fill_in 'comment[body]', with: "New comment\n"

          expect(page).to have_css('p', match: :first, text: 'Comment was succesfully created')
        end

        scenario 'when failure' do
          fill_in 'comment[body]', with: "\n"

          expect(page).to have_css('p', match: :first, text: 'Comment not created')
        end
      end

      context 'destroy comment' do
        let!(:comment) { create :comment, user: user, commentable: Lesson.last, body: 'Comment body' }

        before { visit course_lesson_path(course, Lesson.last) }

        specify do
          expect(page).to have_content('Comment body')

          find(:css, "a[href='/lessons/#{Lesson.last.id}/comments/#{comment.id}']").click

          expect(page).to_not have_content('Comment body')
        end
      end
    end
  end
end
