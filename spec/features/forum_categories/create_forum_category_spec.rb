require 'rails_helper'

RSpec.feature 'creating a category' do
  context 'as a normal user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'redirects the user' do
      page.set_rack_session(user_id: user_1.id)
      visit new_forum_category_path

      expect(page).to have_content 'Permission denied'
    end
  end

  context 'as an admin user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    context 'with invalid details' do
      it 'returns an error' do
        page.set_rack_session(user_id: user_1.id)
        visit new_forum_category_path

        fill_in 'Title', with: ''
        click_on 'Create category'

        expect(page).to have_content 'Invalid details'
      end
    end

    context 'with valid details' do
      it 'creates the category' do
        page.set_rack_session(user_id: user_1)
        visit new_forum_category_path

        fill_in 'Title', with: 'New category title'
        click_on 'Create category'

        expect(page).to have_content 'Category created'
      end
    end
  end
end
