require 'rails_helper'

RSpec.feature 'user logs in' do
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  context 'with valid details' do

    before do
      user_1
    end

    it 'logs the user in' do
      visit login_path

      fill_in :session_email, with: 'test@test.com'
      fill_in :session_password, with: 'password'
      click_on 'Log In'

      expect(page).to have_content('Logged in')
    end
  end

  context 'with invalid details' do

    it 'returns an error' do
      visit login_path

      fill_in :session_email, with: 'test@test.com'
      fill_in :session_password, with: 'wrongpassword'
      click_on 'Log In'

      expect(page).to have_content('Invalid email/password combination')
    end
  end
end
