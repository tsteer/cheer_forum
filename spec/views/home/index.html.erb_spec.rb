require 'rails_helper'

RSpec.describe 'home/index' do

  context 'with 2 threads' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
    let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1, message: 'Test message') }
    let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_1, user: user_1, message: 'Test message') }

    before do
      user_1
      forum_category_1
      forum_thread_1
      forum_thread_2
    end

    it 'displays 2 threads' do
      assign(:forum_threads, [forum_thread_1, forum_thread_2])

      render

      expect(rendered).to match /Forum thread title 1/
    end
  end

  context 'with 2 articles' do
    let(:article_1) do 
      Article.create(
        author: 'Test author 1', 
        title: 'Test title 1', 
        subheading: 'Test subheading 1', 
        article_text: 'Test article text 1') 
    end

    let(:article_2) do
      Article.create(
        author: 'Test author 2',
        title: 'Test title 2',
        subheading: 'Test subheading 2',
        article_text: 'Test article text 2')
    end

    it 'displays 2 categories' do
      assign(:articles, [article_1, article_2])

      render

      expect(rendered).to match /Test title 1/
      expect(rendered).to match /Test title 2/
    end
  end


end
