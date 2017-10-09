require 'rails_helper'

RSpec.feature 'accessibility without a user' do
  context 'create a category' do
    it 'redirects the user' do
      visit new_forum_category_path

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'edit a category' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'redirects the user' do
      visit edit_forum_category_path(forum_category_1)

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'delete a category' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'does not display the link' do
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Delete category')
    end
  end

  context 'show all categories' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_category_2) { ForumCategory.create(title: 'Forum category title 2') }

    before do
      forum_category_1
      forum_category_2
    end

    it 'displays 2 categories' do
      visit forum_categories_path

      expect(page).to have_content('Forum category title 1')
      expect(page).to have_content('Forum category title 2')
    end
  end

  context 'show a category' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'displays the category' do
      visit forum_category_path(forum_category_1)

      expect(page).to have_content('Forum category title 1')
    end
  end

  context 'create a thread' do
    it 'redirects the user'do
      visit new_forum_thread_path

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'edit a thread' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }

    it 'redirects the user' do
      visit edit_forum_thread_path(forum_thread_1)

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'delete a thread' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }

    it 'does not display the link' do
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Delete thread')
    end
  end

  context 'show a thread' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }

    it 'shows the thread' do
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Forum thread title')
    end
  end

  context 'create a post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }

    it 'does not show the post form' do
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Reply')
    end
  end

  context 'edit a post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    it 'redirects the user' do
      visit edit_forum_post_path(forum_post_1)

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'delete a post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    it 'does not display the link' do
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Delete post')
    end
  end

  context 'show a post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1, message: 'Test message') }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    before do
      user_1
      forum_category_1
      forum_thread_1
      forum_post_1
    end

    it 'displays the post' do
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Forum post message 1')
    end
  end

  context 'create an article' do
    it 'redirects the user' do
      visit new_article_path

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'edit an article' do
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'redirects the user' do
      visit edit_article_path(article)

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'delete an article' do
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'does not display the delete link' do
      visit article_path(article)

      expect(page).to_not have_content('Delete article')
    end
  end

  context 'shows all articles' do
    let(:article1) { Article.create(author: 'Test author1', title: 'Test title 1', subheading: 'Test subheading1', article_text: 'Test article text1') }
    let(:article2) { Article.create(author: 'Test author2', title: 'Test title 2', subheading: 'Test subheading2', article_text: 'Test article text2') }

    before do
      article1
      article2
    end

    it 'shows all articles' do
      visit articles_path

      expect(page).to have_content('Test title 1')
      expect(page).to have_content('Test title 2')
    end
  end

  context 'shows an article' do
    let(:article1) { Article.create(author: 'Test author1', title: 'Test title 1', subheading: 'Test subheading1', article_text: 'Test article text1') }
    let(:article2) { Article.create(author: 'Test author2', title: 'Test title 2', subheading: 'Test subheading2', article_text: 'Test article text2') }

    it 'shows the article' do
      visit article_path(article2)

      expect(page).to have_content('Test title 2')
    end
  end

  context 'create a user account' do
    it 'creates an account' do
      visit new_user_path

      expect(page).to have_content('Sign up')
    end
  end

  context 'edit user account' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'redirects the user' do
      visit edit_user_path(user_1)

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'delete user account' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the delete link' do
      visit user_path(user_1)

      expect(page).to_not have_content('Delete account')
    end
  end

  context 'show all users' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'redirects the user' do
      visit users_path

      expect(page).to have_content('You must be logged in to do this')
    end
  end

  context 'show a user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'shows the users page' do
      visit user_path(user_2)

      expect(page).to have_content('You must be logged in to do this')
    end
  end
end
