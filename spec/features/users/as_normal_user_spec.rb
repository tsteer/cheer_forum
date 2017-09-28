require 'rails_helper'

RSpec.feature 'edit and delete links visibility' do

  context 'edit category as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Edit category')
    end
  end

  context 'delete category as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Delete category')
    end
  end

  context 'edit thread as a normal user, who created the thread' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'displays the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Edit thread')
    end
  end

  context 'edit thread as a normal user, who did not create the thread' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'does not display the link' do
      page.set_rack_session(user_id: user_2.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Edit thread')
    end
  end

  context 'delete thread as a normal user, who created the thread' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Delete thread')
    end
  end

  context 'delete thread as a normal user, who did not create the thread' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'does not display the delete link' do
      page.set_rack_session(user_id: user_2.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Delete thread')
    end
  end

  context 'edit post as a normal user, who created the post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    before do
      user_1
      forum_category_1
      forum_thread_1
      forum_post_1
    end

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)
      expect(page).to have_content('Edit post')
    end
  end

  context 'edit post as a normal user, who did not create the post' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_2.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Edit post')
    end
  end

  context 'delete post as a normal user, who created the post' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }

    before do
      user_1
      forum_category_1
      forum_thread_1
      forum_post_1
    end

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Delete post')
    end
  end

  context 'delete post as a normal user, who did not create the post' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }
    let(:forum_post_1) { ForumPost.create(message: 'Forum post message 1', forum_thread: forum_thread_1, user: user_1) }
    
    before do
      user_1
      forum_category_1
      forum_thread_1
      forum_post_1
    end
    it 'does not display the delete link' do
      page.set_rack_session(user_id: user_2.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Delete post')
    end
  end

  context 'view users own profile page as a normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
    end

    it 'displays the users profile page' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_1)

      expect(page).to have_content('Testusername1')
    end
  end

  context 'view other users profile page as a normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'displays the users profile page' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_2)

      expect(page).to have_content('You do not have permission to access this page')
    end
  end

  context 'edit normal users own account' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
    end

    it 'does display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_1)

      expect(page).to have_content('Edit account')
    end
  end

  context 'edit normal users account on index page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
    end

    it 'redirects them away from index page' do
      page.set_rack_session(user_id: user_1.id)
      visit users_path

      expect(page).to have_content('Permission denied')
    end
  end

  context 'edit other user account as a normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_2.id)
      visit user_path(user_1)

      expect(page).to_not have_content('Edit account')
    end
  end

  context 'delete normal users account on index page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
    end

    it 'redirects them away from the index page' do
      page.set_rack_session(user_id: user_1.id)
      visit users_path

      expect(page).to have_content('Permission denied')
    end
  end

  context 'delete normal users own account on their profile page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
    end

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_1)

      expect(page).to have_content('Delete account')
    end
  end

  context 'delete other user account as normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'Testusername2', email: 'test2@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      user_1
      user_2
    end

    it 'does not display the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit user_path(user_2)

      expect(page).to_not have_content('Delete account')
    end
  end

  context 'edit article as a normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    before do
      user_1
      article
    end

    it 'does not display the link' do
      page.set_rack_session(user_id: user_1.id)
      visit article_path(article)

      expect(page).to_not have_content('Edit article')
    end
  end

  context 'delete article as a normal user' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'does not display the link' do
      page.set_rack_session(user_id: user_1.id)
      visit article_path(article)

      expect(page).to_not have_content('Delete article')
    end
  end

  context 'visit sign up page' do
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'redirects the user' do
      page.set_rack_session(user_id: user_1.id)
      visit new_user_path

      expect(page).to have_content('You are already signed up!')
    end
  end
end
