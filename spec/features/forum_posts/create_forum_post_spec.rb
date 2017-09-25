require 'rails_helper'

RSpec.feature 'creating a forum post' do
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
  let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
  let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1) }

  context 'with valid details' do
    it 'creates the forum post' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      fill_in 'Message', with: 'Test post message'
      click_on 'Post'

      expect(page).to have_content 'Message posted'
    end
  end

  context 'with invalid details' do
    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit forum_thread_path(forum_thread_1)

      fill_in 'Message', with: ''
      click_on 'Post'

      expect(page).to have_content 'Invalid details'
    end
  end
end
