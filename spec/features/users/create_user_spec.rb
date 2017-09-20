require 'rails_helper'

RSpec.feature 'User signup' do

  context 'with invalid details' do
    it 'returns an error' do
      visit root_path

      click_on('Sign up')
      fill_in 'Username', with: 'Emily Brown'
      click_button 'Create account'

      expect(page).to have_text('Invalid details')
      expect(page).to have_field('Username', with: 'Emily Brown')
    end
  end

  context 'with valid details' do
    it 'creates a user' do
      visit root_path

      click_on('Sign up')
      fill_in 'Username', with: 'Emily Brown'
      fill_in 'Email', with: 'emilybrown@test.com'
      fill_in 'Date of birth', with: '01/01/1990'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Create account'

      expect(page).to have_text('User created')
    end
  end
end
