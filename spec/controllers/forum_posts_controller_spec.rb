require 'rails_helper'

RSpec.describe ForumPostsController, type: :controller do
  let(:message_1) { 'Test post message 1' }
  let(:message_2) { 'Test post message 2' }
  let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
  let(:forum_category_1) { ForumCategory.create(title: 'Testcategory') }
  let(:forum_thread_1) { ForumThread.create(title: 'Testthread1', forum_category_id: forum_category_1.id, user_id: user_1.id) }
 
  describe '#create' do
    context 'with invalid data' do
      it 'returns an error' do
        post :create, params: { forum_post: { message: '' } }

        expect(response.body).to include('Please complete all required fields')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid data' do
      it 'returns the post' do
        post :create, params: { forum_post: { message: message_1, forum_thread_id: forum_thread_1.id, user_id: user_1.id } }

        expect(JSON.parse(response.body)['message']).to eq('Test post message 1')
      end
    end
  end

  describe '#index' do
    context 'with no posts' do
      it 'returns no posts' do
        get :index

        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'with 2 posts' do
      let(:forum_post_1) { ForumPost.create(message: message_1, forum_thread_id: forum_thread_1.id, user_id: user_1.id) }
      let(:forum_post_2) { ForumPost.create(message: message_2, forum_thread_id: forum_thread_1.id, user_id: user_1.id) }
      before do
        forum_post_1
        forum_post_2
      end
      it 'returns 2 posts' do
        get :index
        expect(JSON.parse(response.body).first['message']).to eq('Test post message 1')
        expect(JSON.parse(response.body).second['message']).to eq('Test post message 2')
      end
    end
  end

  describe '#show' do
    context 'with no posts' do
      it 'returns an error' do
        get :show, params: { id: 9 }

        expect(response.body).to include('Post does not exist')
        expect(response.status).to eq(404)
      end
    end

    context 'with 2 posts' do
      let(:forum_post_1) { ForumPost.create(message: message_1, forum_thread_id: forum_thread_1.id, user_id: user_1.id) }
      let(:forum_post_2) { ForumPost.create(message: message_2, forum_thread_id: forum_thread_1.id, user_id: user_1.id) }
      
      it 'returns 1 post' do
        get :show, params: { id: forum_post_2.id }

        expect(JSON.parse(response.body)['message']).to eq('Test post message 2')
      end
    end
  end

  describe '#update' do
    let(:forum_post_1) { ForumPost.create(message: message_1, forum_thread_id: forum_thread_1.id, user_id: user_1.id) }
    context 'with no data' do

      it 'returns an error' do
        post :update, params: { id: forum_post_1.id, forum_post: {} }

        expect(response.body).to include('No forum post details provided')
        expect(response.status).to eq(422)
      end
    end

    context 'with invalid data' do
      it 'returns an error' do
        post :update, params: { id: forum_post_1.id, forum_post: { message: '' } }

        expect(response.body).to include('Did not submit the required fields')
        expect(response.status).to eq(422)
      end
    end

    context ' with valid data' do
      it 'returns the forum post' do
        post :update, params: { id: forum_post_1.id, forum_post: { message: 'New forum post message' } }

        expect(JSON.parse(response.body)['message']).to eq('New forum post message')
      end
    end
  end

  
end
