require 'rails_helper'

RSpec.describe ForumThread, type: :model do
  let(:title) { nil }
  let(:forum_category) { nil }
  let(:user) { nil }
  let(:forum_thread) { ForumThread.new(title: title, forum_category: forum_category, user: user) }
  subject { forum_thread }

  describe 'validate forum thread' do
    context 'with no title, no forum category and no user' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title, no forum category and no user' do
      let(:title) { 'Thread example title' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title, a forum category and no user' do
      let(:title) { 'Thread example title' }
      let(:forum_category) { ForumCategory.new(title: 'Example category title') }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a title, a forum category and a user' do
      let(:title) { 'Thread example title' }
      let(:forum_category) { ForumCategory.new(title: 'Example category title') }
      let(:user) { User.new(username: 'testusername', email: 'test@test.com', date_of_birth: '31-09-17', password: 'password', password_confirmation: 'password') }
      it('is valid') { is_expected.to be_valid }
    end
  end
end
