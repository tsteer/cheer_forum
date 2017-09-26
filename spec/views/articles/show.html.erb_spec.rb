require 'rails_helper'

RSpec.describe 'articles/show' do
  let(:article_1) { Article.create(author: 'Test author 1', title: 'Test title 1', subheading: 'Test subheading 1', article_text: 'Test article text 1') }
  let(:article_2) { Article.create(author: 'Test author 2', title: 'Test title 2', subheading: 'Test subheading 2', article_text: 'Test article text 2') }

  context 'with a normal user and 2 articles' do
    it 'displays the chosen article' do
      assign(:article, article_2)

      render

      expect(rendered).to match /Test author 2/
      expect(rendered).not_to match /Test author 1/
    end
  end
end
