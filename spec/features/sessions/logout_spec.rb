require 'rails_helper'

RSpec.feature 'user logs out' do
  context 'with a logged in user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    it 'logs the user out' do
      visit login_path

      fill_in :session_email, with: 'test@test.com'
      fill_in :session_password, with: 'password'
      click_on 'Log In'

      click_on 'Log out'

      expect(page).to have_content('Logged out')
    end
  end
end
