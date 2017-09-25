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

  context 'edit category as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Edit category')
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

  context 'delete category as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Delete category')
    end
  end

  context 'edit thread as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'displays the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Edit thread')
    end
  end

  context 'edit thread as a normal user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Edit thread')
    end
  end

  context 'delete thread as an admin' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to have_content('Delete thread')
    end
  end

  context 'delete thread as a normal user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

    it 'does not display the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      expect(page).to_not have_content('Delete thread')
    end
  end
end
