require 'rails_helper'

RSpec.feature 'creating a thread' do
  context 'with invalid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }

    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit new_forum_thread_path

      fill_in 'Title', with: ''
      click_on 'Create thread'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
    let(:forum_category_2) { ForumCategory.create(title: 'Category name 2') }

    before do
      forum_category_1
      forum_category_2
      user_1
    end

    it 'creates the thread' do
      page.set_rack_session(user_id: user_1.id)
      visit new_forum_thread_path

      fill_in 'Title', with: 'New forum thread'
      select forum_category_2.title, from: 'Forum category'
      click_on 'Create thread'

      expect(page).to have_content 'Thread created'
    end
  end
end
