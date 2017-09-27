require 'rails_helper'

RSpec.describe 'forum_categories/index' do
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
  let(:forum_category_2) { ForumCategory.create(title: 'Category name 2') }
  let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1) }
  let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_2, user: user_1) }
  
  context 'with no categories' do
    it 'displays a message' do
      assign(:forum_categories, [])

      render

      expect(rendered).to match /There are no categories/
    end
  end

  context 'with 2 categories' do 
    it 'displays the categories' do
      assign(:forum_categories, [forum_category_1, forum_category_2])
      
      render

      expect(rendered).to match /Category name 1/
      expect(rendered).to match /Category name 2/
    end
  end

  context 'with 2 categories and 2 threads' do
    it 'displays the categories and threads' do
      assign(:forum_categories, [forum_category_1, forum_category_2])
      assign(:forum_threads, [forum_thread_1, forum_thread_2])
      render

      expect(rendered).to match /Category name 1/
      expect(rendered).to match /Category name 2/
      expect(rendered).to match /Forum thread title 1/
      expect(rendered).to match /Forum thread title 2/
    end
  end
end
