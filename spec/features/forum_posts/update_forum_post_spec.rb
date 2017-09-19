require 'rails_helper'

RSpec.feature 'updating a post' do
  context 'with no post' do
    it 'returns an error' do
      visit edit_forum_post_path(id: 2332)

      expect(page).to have_content '404'
      expect(page).to have_http_status(404)
    end
  end

  context 'with invalid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    before do
      forum_post_1
    end
    
    it 'returns an error' do
      visit edit_forum_post_path(forum_post_1)

      fill_in 'Message', with: ''
      click_on 'Update post'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    before do
      forum_post_1
    end
    
    it 'updates the post' do
      visit edit_forum_post_path(forum_post_1)

      fill_in 'Message', with: 'New forum post message'
      click_on 'Update post'

      expect(page).to have_content 'Post updated'
    end
  end
end