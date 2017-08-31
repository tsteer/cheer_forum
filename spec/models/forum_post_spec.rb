require 'rails_helper'

RSpec.describe ForumPost, type: :model do
  let(:message) { nil }
  let(:forum_thread) { nil }
  let(:forum_post) { ForumPost.new(message: message, forum_thread: forum_thread) }

  subject { forum_post }

  describe 'validate forum post' do
    context 'with no message' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a message' do
      let(:message) { 'Test forum post' }
      it('is not valid') { is_expected.to_not be_valid }

      context 'and a forum thread id' do
        let(:forum_thread) { ForumThread.new(title: 'Thread example title') }
        it('is valid') { is_expected.to be_valid }
      end
    end
  end
end
