require 'rails_helper'

RSpec.describe ForumCategory, type: :model do
  let(:title) { nil }
  let(:forum_category) { ForumCategory.new(title: title) }

  subject { forum_category }

  describe 'validate forum category' do
    context 'with no title' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title' do
      let(:title) { 'Category title example' }
      it('is not valid') { is_expected.to be_valid }
    end
  end
end
