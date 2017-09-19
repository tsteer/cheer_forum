require 'rails_helper'

RSpec.feature 'forum_categories/show' do
  context 'with 2 categories' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_category_2) { ForumCategory.create(title: 'Forum category title 2') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1) }
    let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_2, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }
    let(:forum_post_2) { ForumPost.create(message: 'Forum post message 2', forum_thread: forum_thread_2, user: user_1) }
    
    before do
      forum_category_1
      forum_category_2
      forum_thread_1
      forum_thread_2
      forum_post_1
      forum_post_2
    end
    
    it 'deletes 1 category' do
      visit forum_category_path(forum_category_2)

      click_on 'Delete category'

      expect(page).to have_content 'Category deleted'
      expect(ForumCategory.count).to eq(1)
      expect(ForumThread.count).to eq(1)
      expect(ForumPost.count).to eq(1)
    end
  end
end
