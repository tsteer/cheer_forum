require 'rails_helper'

RSpec.feature 'updating a category' do
  context 'with no category' do
    it 'returns an error' do
      visit edit_forum_category_path(id: 9999)

      expect(page).to have_content '404'
      expect(page).to have_http_status(404)
    end
  end
  
  context 'with invalid details as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_forum_category_path(forum_category_1)

      fill_in 'Title', with: ''
      click_on 'Update category'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'updates the category title' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_forum_category_path(forum_category_1)

      fill_in 'Title', with: 'New category title'
      click_on 'Update category'

      expect(page).to have_content 'Category updated'
    end
  end
end
