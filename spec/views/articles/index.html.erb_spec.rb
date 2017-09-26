require 'rails_helper'

RSpec.describe 'articles/index' do
  let(:article_1) do 
    Article.create(
      author: 'Test author 1', 
      title: 'Test title 1', 
      subheading: 'Test subheading 1', 
      article_text: 'Test article text 1') 
  end

  let(:article_2) do
    Article.create(
      author: 'Test author 2',
      title: 'Test title 2',
      subheading: 'Test subheading 2',
      article_text: 'Test article text 2')
  end

  context 'with no articles' do
    it 'displays a message telling the user there are no articles' do
      assign(:articles, [])

      render

      expect(rendered).to match /There are no articles/
    end
  end

  context 'with 2 articles' do
    it 'displays the articles' do
      assign(:articles, [article_1, article_2])

      render

      expect(rendered).to match /Test author 1/
      expect(rendered).to match /Test author 2/
    end
  end
end
