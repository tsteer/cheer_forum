require 'rails_helper'

RSpec.describe ForumPost, type: :model do
  let(:message) { nil }
  let(:forum_thread) { nil }
  let(:user) { nil }
  let(:forum_post) { ForumPost.new(message: message, forum_thread: forum_thread, user: user) }

  subject { forum_post }

  describe 'validate forum post' do
    context 'with no message, no forum thread and no user' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a message, no forum thread and no user' do
      let(:message) { 'Test forum post' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a message, forum thread and no user' do
      let(:message) { 'Test forum post' }
      let(:forum_thread) { ForumThread.new(title: 'Thread example title') }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a message, forum thread and user' do
      let(:message) { 'Test forum post' }
      let(:forum_thread) { ForumThread.new(title: 'Thread example title') }
      let(:user) { User.new(username: 'testusername', email: 'test@test.com', date_of_birth: '31-09-17') }
      it('is valid') { is_expected.to be_valid }
    end
  end
end
