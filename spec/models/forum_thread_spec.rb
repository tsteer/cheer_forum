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

  describe '.latest' do
    context 'with 4 threads' do
      let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }
      let(:forum_category_1) { ForumCategory.create(title: 'Test category title 1') }
      let(:forum_category_2) { ForumCategory.create(title: 'Test category title 2') }
      let(:forum_thread_1) { ForumThread.create(title: 'Forum thread title 1', forum_category: forum_category_1, user: user_1, updated_at: Date.today-1.week) }
      let(:forum_thread_2) { ForumThread.create(title: 'Forum thread title 2', forum_category: forum_category_2, user: user_1, updated_at: Date.today-1.day) }
      let(:forum_thread_3) { ForumThread.create(title: 'Forum thread title 3', forum_category: forum_category_1, user: user_1, updated_at: Date.today-1.month) }
      let(:forum_thread_4) { ForumThread.create(title: 'Forum thread title 4', forum_category: forum_category_2, user: user_1, updated_at: Date.today-3.days) }

      before do
        user_1
        forum_category_1
        forum_category_2
        forum_thread_1
        forum_thread_2
        forum_thread_3
        forum_thread_4
      end

      it 'returns the three most recently updated posts' do
        expect(ForumThread.latest).to eq([forum_thread_2, forum_thread_4, forum_thread_1])
      end
    end
  end
end
