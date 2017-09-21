require 'rails_helper'

RSpec.feature 'edit and delete links visibility' do

  context 'edit as an admin' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    it 'display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to have_content('Edit category')
    end
  end

  context 'edit as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the edit link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Edit category')
    end
  end

  context 'delete as an admin' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    it 'displays the delete link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to have_content('Delete category')
    end
  end

  context 'delete as normal user' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    it 'does not display the link' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_category_path(forum_category_1)

      expect(page).to_not have_content('Delete category')
    end
  end
end
