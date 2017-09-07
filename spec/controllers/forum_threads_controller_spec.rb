require 'rails_helper'

RSpec.describe ForumThreadsController, type: :controller do
  describe '#create' do
    context 'with invalid data' do

      it 'returns an error' do
        post :create, params: { forum_thread: { title: '' } }

        expect(response.body).to include('Please complete all required fields')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid data' do
      let(:user) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
      let(:forum_category) { ForumCategory.create(title: 'Testcategory') }

      it 'returns the category' do
        post :create, params: { forum_thread: { title: 'Testthread', forum_category_id: forum_category.id, user_id: user.id } }

        expect(JSON.parse(response.body)['title']).to eq('Testthread')
      end
    end
  end

  describe '#index' do
    context 'with no threads' do
      it 'returns no threads' do
        get :index

        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'with 2 threads' do
      let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
      let(:forum_category_1) { ForumCategory.create(title: 'Testcategory') }
      let(:forum_thread_1) { ForumThread.create(title: 'Testthread1', forum_category_id: forum_category_1.id, user_id: user_1.id) }
      let(:forum_thread_2) { ForumThread.create(title: 'Testthread2', forum_category_id: forum_category_1.id, user_id: user_1.id) }
      before do
        forum_thread_1
        forum_thread_2
      end

      it 'returns 2 threads' do
        get :index

        expect(response.body).to eq([forum_thread_1, forum_thread_2].to_json)
      end
    end
  end

  describe '#show' do
    context 'with no threads' do
      it 'returns no threads' do
        get :show, params: { id: 7 }

        expect(response.body).to include('Thread does not exist')
        expect(response.status).to eq(404)
      end
    end

    context 'with 2 threads' do
      let(:user_1) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01') }
      let(:forum_category_1) { ForumCategory.create(title: 'Testcategory') }
      let(:forum_thread_1) { ForumThread.create(title: 'Testthread1', forum_category_id: forum_category_1.id, user_id: user_1.id) }
      let(:forum_thread_2) { ForumThread.create(title: 'Testthread2', forum_category_id: forum_category_1.id, user_id: user_1.id) }
      
      it 'returns 1 thread' do
        get :show, params: { id: forum_thread_2.id }

        expect(JSON.parse(response.body)['title']).to eq('Testthread2')
      end
    end
  end
end
