require 'rails_helper'

RSpec.feature 'forum_threads/show' do
  context 'with 2 posts' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }
    let(:forum_post_2) { ForumPost.create(message: 'Forum post message 2', forum_thread: forum_thread_1, user: user_1) }

    before do
      forum_post_1
      forum_post_2
    end

    it 'deletes 1 post as an admin' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)
      page.all(:css, '.delete-post').first.click

      expect(page).to have_content 'Post deleted'
      expect(ForumPost.count).to eq(1)
    end
  end
end
