require 'rails_helper'

RSpec.feature 'delete user' do

  context 'with no user' do
    it 'returns an error' do
      visit user_path(id: 32863)

      expect(page).to have_content '404'
    end
  end

  context 'with 2 users' do
  let(:user_1) { User.create(username: 'Testusername1', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  let(:user_2) { User.create(username: 'Testusername2', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }

  before do
    user_1
    user_2
  end

    it 'deletes 1 user' do
      visit user_path(user_2)

      click_on 'Delete account'

      expect(page).to have_text('Account deleted')
      expect(User.count).to eq(1)
    end
  end
end
