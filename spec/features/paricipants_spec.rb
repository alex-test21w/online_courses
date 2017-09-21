require 'rails_helper'

RSpec.feature 'Participants', type: :feature, js: true do
  let(:user) { create :user }

  before     { login_as(user) }

  feature 'Participants of course' do
    context 'Expel student' do
      let(:course) { create :course, user: user }
      let!(:course_users) { create_list :course_user, 2, course: course, subscription: true }

      before { visit course_participants_path(course) }

      scenario 'Show course' do
        click_on 'Expel student', match: :first

        expect(page).to have_content('Student expelled')
      end
    end
  end
end
