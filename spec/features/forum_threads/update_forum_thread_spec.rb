require 'rails_helper'

RSpec.describe 'updating a thread' do
  context 'with no thread' do
    it 'returns an error' do
      visit edit_forum_thread_path(id: 89303)

      expect(page).to have_content 'not found'
    end
  end

  context 'with invalid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'returns an error' do
      visit edit_forum_thread_path(forum_thread_1)

      fill_in 'Title', with: ''
      click_on 'Update thread'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'updates the thread name' do
      visit edit_forum_thread_path(forum_thread_1)

      fill_in 'Title', with: 'New forum thread title'
      click_on 'Update thread'

      expect(page).to have_content 'Thread updated'
    end
  end
end
