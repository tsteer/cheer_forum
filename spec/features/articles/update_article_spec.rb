require 'rails_helper'

RSpec.feature 'updating an article' do

  context 'as a normal user with invalid input' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'returns an error' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_article_path(article)

      fill_in 'Article text', with: ''
      click_on 'Update article'

      expect(page).to have_content 'Invalid details'
    end
  end
  
  context 'as a normal user with valid input' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'updates the article' do
      page.set_rack_session(user_id: user_1.id)
      visit edit_article_path(article)

      fill_in 'Article text', with: 'New article text'
      click_on 'Update article'

      expect(page).to have_content 'Article updated'
    end
  end
end

