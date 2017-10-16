require 'rails_helper'

RSpec.feature 'resetting a users password' do
  let!(:user) { User.create(username: 'Testusername', email: 'test91@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
  ActionMailer::Base.deliveries.clear

  context 'with an invalid email' do
    it 'displays an error' do
      visit new_password_reset_path

      fill_in :password_reset_email, with: ''
      click_on 'Submit'

      expect(page).to have_content 'Email address not found'
    end
  end

  context 'with a valid email' do
    it 'sends a reset email' do
      visit new_password_reset_path

      fill_in :password_reset_email, with: 'test91@test.com'
      click_on 'Submit'
      expect(page).to have_content 'Reset password email sent'
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    context 'with the correct email and token' do
      it 'resets the password' do
        user.create_reset_digest

        visit edit_password_reset_path(id: user.reset_token, email: user.email)

        fill_in 'Password', with: 'newpassword'
        fill_in 'Password confirmation', with: 'newpassword'
        click_on 'Update password'

        expect(page).to have_content 'Password has been reset'
        user.reload
        expect(user.reset_digest).to eq(nil)
      end
    end

    context 'with the correct email and wrong token' do
      it 'displays an error' do
        user.create_reset_digest

        visit edit_password_reset_path(id: '', email: user.email)

        expect(page).to have_content 'You are not authorized to view this page'
      end
    end

    context 'with the correct email and token but no passwords entered' do
      it 'displays an error' do
        user.create_reset_digest

        visit edit_password_reset_path(id: user.reset_token, email: user.email)

        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        click_on 'Update password'

        expect(page).to have_content 'Cannot be empty'
      end
    end

    context 'with the correct email and token but an invalid password and confirmation' do
      it 'displays an error' do
        user.create_reset_digest

        visit edit_password_reset_path(id: user.reset_token, email: user.email)

        fill_in 'Password', with: 'newpassword'
        fill_in 'Password confirmation', with: 'dhjfksd'
        click_on 'Update password'

        expect(page).to have_content 'Password and confirmation must match'
      end
    end

    context 'with an expired token' do
      it 'displays an error' do
        user.create_reset_digest
        user.update_attribute(:reset_sent_at, 3.hours.ago)

        visit edit_password_reset_path(id: user.reset_token, email: user.email)

        expect(page).to have_content 'Password reset has expired'
      end
    end
  end
end
