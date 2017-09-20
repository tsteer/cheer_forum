require 'rails_helper'

RSpec.describe 'forum_threads/show' do
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
  let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1) }
  let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_1, user: user_1) }
  let(:forum_post_1) { ForumPost.create(message: 'Forum post 1', forum_thread: forum_thread_2, user: user_1) }
  let(:forum_post_2) { ForumPost.create(message: 'Forum post 2', forum_thread: forum_thread_1, user: user_1) }
  let(:forum_post_3) { ForumPost.create(message: 'Forum post 3', forum_thread: forum_thread_2, user: user_1) }

  before do
    forum_post_1
    forum_post_2
    forum_post_3
  end

  context 'with 3 posts in 2 different threads' do
    it 'displays the 2 posts in the specified thread' do
      assign(:forum_thread, forum_thread_2)
      assign(:forum_post, forum_thread_2.forum_posts.new)

      render

      expect(rendered).to match /Forum post 1/
      expect(rendered).to match /Forum post 3/
      expect(rendered).not_to match /Forum post 2/
    end
  end
end
