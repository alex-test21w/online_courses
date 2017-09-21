require 'rails_helper'

RSpec.feature 'Courses of user', type: :feature do
  let(:user) { create :user, :add_trainer }
  before { login_as(user) }

  feature 'Index Page' do
    let!(:course) { create :course, user: user }

    before { visit users_courses_path }

    scenario 'should display course title' do
      expect(page).to have_content course.title
    end
  end

  feature 'Create course' do
    before do
      visit users_courses_path
      click_on 'Add Course'
    end

    specify do
      within('form#new_course') do
        fill_in 'course[title]', with: 'New title'
        attach_file('course[picture]', "#{Rails.root}/spec/fixtures/pixel.png")
      end

      click_on 'Create Course'

      expect(page).to have_content 'New title'
      expect(page.current_path).to eq users_courses_path
    end
  end

  feature 'Update course' do
    let!(:course) { create :course, title: 'Init Title', user: user }

    before do
      visit users_courses_path
      click_on 'edit'
    end

    specify do
      within("form#edit_course_#{course.id}") do
        fill_in 'course[title]', with: 'New title'
      end

      click_on 'Update Course'

      expect(page).to have_content 'New title'
      expect(page).to_not have_content 'Init Title'
      expect(page.current_path).to eq users_courses_path
    end
  end

  feature 'Destroy' do
    let!(:course) { create :course, title: 'Init Title', user: user }

    before do
      visit users_courses_path
      click_on 'delete'
    end

    specify do
      expect(page).to have_content 'No Courses'
      expect(page).to_not have_content 'Init Title'
      expect(page.current_path).to eq users_courses_path
    end
  end
end
