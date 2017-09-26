require 'rails_helper'

RSpec.feature 'delete an article' do
  context 'as a normal user' do
    let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }
    let(:article) { Article.create(author: 'Test author', title: 'Test title', subheading: 'Test subheading', article_text: 'Test article text') }

    it 'deletes the article as an admin' do
      page.set_rack_session(user_id: user_1.id)
      visit article_path(article)

      click_on 'Delete article'

      expect(page).to have_content('Article deleted')
      expect(Article.count).to eq(0)
    end
  end
end
