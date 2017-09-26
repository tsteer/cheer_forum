require 'rails_helper'

RSpec.describe 'articles/show' do
  context 'with a normal user and 2 articles' do
    let(:article_1) { Article.create(author: 'Test author 1', title: 'Test title 1', subheading: 'Test subheading 1', article_text: 'Test article text 1') }
    let(:article_2) { Article.create(author: 'Test author 2', title: 'Test title 2', subheading: 'Test subheading 2', article_text: 'Test article text 2') }
    let(:user_1) { User.create(username: 'Testusername1', email: 'test1@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before do
      article_1
      article_2
      allow(view).to receive(:current_user).and_return(user_1)
    end

    it 'displays the chosen article' do
      assign(:article, article_2)

      render

      expect(rendered).to match /Test author 2/
      expect(rendered).not_to match /Test author 1/
    end
  end
end
