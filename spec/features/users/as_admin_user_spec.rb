require 'rails_helper'

RSpec.feature 'edit and delete links visibility' do

  context 'edit category as an admin' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    it 'displays the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to have_content('Edit category')
    end
  end

  context 'delete category as an admin' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to have_content('Delete category')
    end
  end

  context 'edit thread as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_2) }

    it 'displays the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Edit thread')
    end
  end

  context 'delete thread as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_2) }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Delete thread')
    end
  end

  context 'edit post as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_2) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_2) }

    before do
      user_1
      user_2
      forum_category_1
      forum_thread_1
      forum_post_1
    end

    it 'displays the edit post link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Edit post')
    end
  end

  context 'delete post as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_2) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_2) }

    before do
      user_1
      user_2
      forum_category_1
      forum_thread_1
      forum_post_1
    end

    it 'displays the delete post link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Delete post')
    end
  end

  context 'edit user as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'displays the edit user link' do
      page.set_rack_session(user_id: user_1.id)
      visit users_path

      expect(page).to have_content('Edit user')
    end
  end

  context 'edit user as an admin on the users profile page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'displays the edit user link' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_2)

      expect(page).to have_content('Edit account')
    end
  end

  context 'delete user as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'displays the delete user link' do
      page.set_rack_session(user_id: user_1.id)
      visit users_path

      expect(page).to have_content('Delete user')
    end
  end

  context 'delete user as an admin on the users profile page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_2)

      expect(page).to have_content('Delete account')
    end
  end

  context 'edit article as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'displays the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit article_path(article)

      expect(page).to have_content('Edit article')
    end
  end

  context 'delete article as an admin' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit article_path(article)

      expect(page).to have_content('Delete article')
    end
  end
end
