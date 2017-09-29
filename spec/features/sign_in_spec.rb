require 'rails_helper'

RSpec.feature 'Sign in', type: :feature do
  feature 'Process sign in' do
    let!(:user) { create :user, email: 'email@mail.com', password: '111111' }

    before do
      visit '/'
      click_on 'Sign in'
    end

    specify do
      expect(page).to have_css('b', 'Log in')
      expect(page.current_path).to eq new_user_session_path
    end

    context 'with devise' do
      scenario 'with valid data' do
        fill_in 'Email', with: 'email@mail.com'
        fill_in 'Password', with: '111111'

        click_on 'Sign In'

        expect(page).to have_css('.pull-left.info', text: user.first_name)
        expect(page).to have_content user.last_name
        expect(page).to_not have_content 'Log in'
      end

      scenario 'with invalid data' do
        fill_in 'Email', with: 'not_email@mail.com'
        fill_in 'Password', with: '111111'

        click_on 'Sign In'

        expect(page).to have_css('b', 'Log in')
        expect(page.current_path).to eq new_user_session_path
      end
    end

    context 'with oauth' do
      scenario 'auth via twitter' do
        mock_auth_twitter

        click_on 'Sign in with Twitter'

        expect(page).to have_content 'mockuser'
        expect(page.current_path).to eq root_path
      end

      scenario 'auth via facebook' do
        mock_auth_facebook

        click_on 'Sign up using Facebook'

        expect(page).to have_content 'mockuser'
        expect(page.current_path).to eq root_path
      end
    end
  end
end
