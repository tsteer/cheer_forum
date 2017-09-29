require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:author) { nil }
  let(:title) { nil }
  let(:subheading) { nil }
  let(:article_text) { nil }
  let(:article) { Article.new(author: author, title: title, subheading: subheading, article_text: article_text) }

  subject { article }

  describe 'validate article' do
    context 'with no author, title, subheading or article text' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with an author but no title, subheading or article text' do
      let(:author) { 'Article author' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with an author and title, but no subheading or article text' do
      let(:author) { 'Article author' }
      let(:title) { 'Article title' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with an author, title, subheading but no article text' do
      let(:author) { 'Article author' }
      let(:title) { 'Article title' }
      let(:subheading) { 'Subheading' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with an author, title, subheading and article text' do
      let(:author) { 'Article author' }
      let(:title) { 'Article title' }
      let(:subheading) { 'Subheading' }
      let(:article_text) { 'Article text' }
      it('is valid') { is_expected.to be_valid }
    end
  end

  describe '.latest' do
    context 'with 4 articles' do
      let(:article1) { Article.create(author: 'Test author 1', title: 'Test title 1', subheading: 'Test subheading 1', article_text: 'Test article text 1', updated_at: Date.today-1.day) }
      let(:article2) { Article.create(author: 'Test author 2', title: 'Test title 2', subheading: 'Test subheading 2', article_text: 'Test article text 2', updated_at: Date.today-1.month) }
      let(:article3) { Article.create(author: 'Test author 3', title: 'Test title 3', subheading: 'Test subheading 3', article_text: 'Test article text 3', updated_at: Date.today-2.days) }
      let(:article4) { Article.create(author: 'Test author 4', title: 'Test title 4', subheading: 'Test subheading 4', article_text: 'Test article text 4', updated_at: Date.today-1.week) }

      before do
        article1
        article2
        article3
        article4
      end

      it 'returns the three most recently updated articles' do
        expect(Article.latest).to eq([article1, article3, article4])
      end
    end
  end
end
