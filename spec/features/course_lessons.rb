require 'rails_helper'

RSpec.feature 'Course lessons', type: :feature, js: true do
  let(:user) { create :user }

  before     { login_as(user) }

  feature 'Index page' do
    #let!(:course) { create :course, lessons: create_list(:lessons, 2) }
    #let!(:course_user) { create :course_user, user: user, course: course, subscription: true }

    #before { visit course_lessons(course) }

    # scenario 'View lesson' do
    #   click_on 'View lesson', match: :first
    #
    #   expect(page).to have_content(course.lessons.first.title)
    # end
  end
end
