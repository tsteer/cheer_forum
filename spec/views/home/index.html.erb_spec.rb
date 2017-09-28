require 'rails_helper'

RSpec.describe 'home/index' do
  context 'with no categories' do
    it 'displays a message' do
      assign(:articles, [])

      render

      expect(rendered).to match /There are no articles/
    end
  end

  context 'with 2 articles' do
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

    it 'displays 2 categories' do
      assign(:articles, [article_1, article_2])

      render

      expect(rendered).to match /Test title 1/
      expect(rendered).to match /Test title 2/
    end
  end
end
