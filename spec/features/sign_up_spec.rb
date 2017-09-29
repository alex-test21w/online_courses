require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  feature 'Process sign up' do
    before do
      visit '/'
      click_on 'Sign up'
    end

    specify do
      expect(page).to have_css('b', text: 'Sign up')
      expect(page.current_path).to eq new_user_registration_path
    end

    scenario 'with valid data' do
      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Johnson'
      fill_in 'Email', with: 'email@mail.com'
      fill_in 'Password', with: '111111'
      fill_in 'Retype password', with: '111111'
      attach_file('user[picture]', "#{Rails.root}/spec/fixtures/pixel.png")

      expect { click_on('Register') }.to change(User, :count).by(1)

      expect(page).to have_css('p', text: 'John Johnson')
      expect(page).to have_css('p', text: 'Welcome! You have signed up successfully.')
      expect(page.current_path).to eq root_path
    end

    context 'with invalid data' do
      scenario 'when all fields are empty' do
        expect { click_on('Register') }.to change(User, :count).by(0)

        expect(page).to have_css('.user_profile_first_name .error', text: 'can\'t be blank')
        expect(page).to have_css('.user_email .error', text: 'can\'t be blank')
        expect(page).to have_css('.user_password .error', text: 'can\'t be blank')
        expect(page.current_path).to eq user_registration_path
      end

      scenario 'when email is incorrect' do
        fill_in 'Email', with: 'email'

        expect { click_on('Register') }.to change(User, :count).by(0)

        expect(page).to have_css('.user_email .error', text: 'is invalid')
        expect(page.current_path).to eq user_registration_path
      end

      scenario 'when password less 6 characters and retype password is empty' do
        fill_in 'Password', with: '123'

        expect { click_on('Register') }.to change(User, :count).by(0)

        expect(page).to have_css('.user_password .error', text: 'minimum is 6 characters')
        expect(page).to have_css('.user_password .error', text: 'is too short (minimum is 6 characters)')
        expect(page).to have_css('.user_password_confirmation .error', text: 'doesn\'t match Password')
        expect(page.current_path).to eq user_registration_path
      end
    end
  end
end
