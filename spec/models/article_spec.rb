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
end
