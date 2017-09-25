require 'rails_helper'

RSpec.feature 'Profile', type: :feature do
  let(:user) { create :user, email: 'test@profile.com' }

  before { login_as(user) }

  feature 'Show page' do
    let(:owner) { create :user }
    let(:homework) { create :homework, user: user }
    let!(:course_user) { create :course_user, user: user, subscription: true }
    let!(:activity) do
      create(
        :activity,
        recipient_id: user.id,
        owner_id: owner.id,
        trackable: homework,
        kind: 'approved',
        message: 'Homework has been approved'
      )
    end

    before { visit users_profile_path }

    specify do
      expect(page).to have_content user.email
      expect(page).to have_selector('.nav.nav-tabs li:first-child.active')
      expect(page).to_not have_selector('.nav.nav-tabs li:nth-child(2).active')
    end

    context 'user subscribed of courses' do
      specify do
        expect(page).to have_content course_user.course.title
      end

      scenario 'check course' do
        click_on course_user.course.title

        expect(page.current_path).to eq course_path(course_user.course)
        expect(page).to have_css('a', text: 'Course')
      end
    end

    context 'activities', js: true do
      before { click_on 'Activity' }

      scenario 'check activities' do
        expect(page).to have_selector('.nav.nav-tabs li:nth-child(2).active')
        expect(page).to_not have_selector('.nav.nav-tabs li:first-child.active')
      end

      scenario 'check activity of homework' do
        expect(page).to have_content activity.message

        click_on 'Check your homework'

        expect(page.current_path).to eq homework_path(homework)
        expect(page).to have_css('a', text: 'Homework')
      end
    end
  end

  feature 'Edit profile' do
    before do
      visit users_profile_path

      click_on 'Edit profile'
    end

    specify do
      expect(page).to have_css('h3', text: 'Edit profile')
    end

    scenario 'when success', js: true do
      fill_in 'user[email]', with: 'new@email.com'

      click_on 'Update profile'

      expect(page.current_path).to eq users_profile_path
    end

    scenario 'when failure' do
      fill_in 'user[email]', with: ''

      click_on 'Update profile'

      expect(page).to have_css('.error', text: 'can\'t be blank')
      expect(page.current_path).to eq users_profile_path
    end
  end
end
