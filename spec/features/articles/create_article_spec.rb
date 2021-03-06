require 'rails_helper'

RSpec.feature 'creating an article' do

  context 'as a normal user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'redirects the user' do
      page.set_rack_session(user_id: user_1.id)
      visit new_article_path

      expect(page).to have_content 'Permission denied'
    end
  end

  context 'as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    context 'with invalid input' do
      it 'returns an error' do
        page.set_rack_session(user_id: user_1.id)
        visit new_article_path

        fill_in 'Author', with: ''
        click_on 'Post article'

        expect(page).to have_content 'Invalid details'
      end
    end

    context 'with valid input' do
      it 'creates an article' do
        page.set_rack_session(user_id: user_1.id)
        visit new_article_path

        fill_in 'Author', with: 'Test author'
        fill_in 'Title', with: 'Test title'
        fill_in 'Subheading', with: 'Test subheading'
        fill_in 'Article text', with: 'Test article text'
        click_on 'Post article'

        expect(page).to have_content 'Article posted'
      end
    end
  end
end
