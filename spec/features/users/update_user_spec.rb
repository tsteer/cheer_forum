require 'rails_helper'

RSpec.feature 'update user' do
  context 'with no user' do
    it 'returns an error' do
      visit edit_user_path(id: 28723)

      expect(page).to have_content '404'
      expect(page).to have_http_status(404)
    end
  end

  context 'with invalid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_user_path(user_1)

      fill_in 'Username', with: ''
      click_on 'Update account'

      expect(page).to have_text('Invalid details')
    end
  end

  context 'with valid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    it 'updates the user' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_user_path(user_1)

      fill_in 'Username', with: 'Newusername'
      click_on 'Update account'

      expect(page).to have_text('User updated')
    end
  end
end
