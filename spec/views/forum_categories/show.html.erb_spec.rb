require 'rails_helper'

RSpec.describe 'forum_categories/show' do
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
  let(:forum_category_2) { ForumCategory.create(title: 'Category name 2') }
  let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1) }
  let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_2, user: user_1) }
  let(:forum_thread_3) { ForumThread.create(title: 'Forum thread title 3', forum_category: forum_category_1, user: user_1) }

  before do
    forum_thread_1
    forum_thread_2
    forum_thread_3
  end

  context 'with 3 threads in 2 different categories' do
    it 'displays the 2 threads in the specified category' do
      assign(:forum_category, forum_category_1)
      
      render

      expect(rendered).to match /Forum thread title 1/
      expect(rendered).to match /Forum thread title 3/
      expect(rendered).not_to match /Forum thread title 2/ 
    end
  end
end
