require 'rails_helper'

RSpec.describe ForumThread, type: :model do
  let(:title) { nil }
  let(:forum_category) { nil }
  let(:forum_thread) { ForumThread.new(title: title, forum_category: forum_category) }
  subject { forum_thread }

  describe 'validate forum thread' do
    context 'with no title' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title and no forum category' do
      let(:title) { 'Thread example title' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title and a forum category' do
      let(:title) { 'Thread example title' }
      let(:forum_category) { ForumCategory.new(title: 'Example category title') }
      it('is valid') { is_expected.to be_valid }
    end
  end
end
