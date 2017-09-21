require 'rails_helper'

RSpec.feature 'user logs out' do
  context 'with a logged in user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }

    it 'logs the user out' do
      page.set_rack_session(user_id: user_1.id)

      visit root_path
      click_on 'Log out'

      expect(page).to have_content('Logged out')
    end
  end
end
