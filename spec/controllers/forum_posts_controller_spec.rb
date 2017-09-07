require 'rails_helper'

RSpec.describe ForumPostsController, type: :controller do
  describe '#create' do
    context 'with invalid data' do
      it 'returns an error' do
        post :create, params: { forum_post: { message: '' } }

        expect(response.body).to include('Please complete all required fields')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid data' do
      let(:message) { 'Test post message' }
      let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
      let(:forum_category_1) { ForumCategory.create(title: 'Testcategory') }
      let(:forum_thread_1) { ForumThread.create(title: 'Testthread1', forum_category_id: forum_category_1.id, user_id: user_1.id) }
      it 'returns the post' do
        post :create, params: { forum_post: { message: message, forum_thread_id: forum_thread_1.id, user_id: user_1.id } }

        expect(JSON.parse(response.body)['message']).to eq('Test post message')
      end
    end
  end
end
