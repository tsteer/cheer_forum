require 'rails_helper'

RSpec.feature 'updating a thread' do
  context 'with no thread' do
    it 'returns an error' do
      visit edit_forum_thread_path(id: 89303)

      expect(page).to have_content '404'
      expect(page).to have_http_status(404)
    end
  end

  context 'with invalid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_forum_thread_path(forum_thread_1)

      fill_in 'Title', with: ''
      click_on 'Update thread'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'updates the thread name' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_forum_thread_path(forum_thread_1)

      fill_in 'Title', with: 'New forum thread title'
      click_on 'Update thread'

      expect(page).to have_content 'Thread updated'
    end
  end
end
