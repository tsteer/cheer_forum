require 'rails_helper'

RSpec.describe ForumThread, type: :model do
  let(:title) { nil }
  let(:forum_thread) { ForumThread.new(title: title) }
  subject { forum_thread }

  describe 'validate forum thread' do
    context 'with no title' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title' do
      let(:title) { 'Thead example title' }
      it('is valid') { is_expected.to be_valid }
    end
  end
end
