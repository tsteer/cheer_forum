require 'rails_helper'

RSpec.describe ForumCategoriesController, type: :controller do
  describe '#create' do
    context 'with invalid data' do
      it 'returns an error' do
        post :create, params: { forum_category: { title: ''} }

        expect(response.body).to include('Please give the category a name')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid data' do
      it 'returns the category' do
        post :create, params: { forum_category: { title: 'Test Category' } }

        expect(JSON.parse(response.body)['title']).to eq('Test Category')
      end
    end
  end

  describe '#index' do
    context 'with no categories' do
      it 'returns no categories' do
        get :index
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'with 2 categories' do
      let!(:forum_category_1) { ForumCategory.create(title: 'Test Category 1') }
      let!(:forum_category_2) { ForumCategory.create(title: 'Test Category 2') }

      it 'returns 2 categories' do
        get :index

        expect(response.body).to eq([forum_category_1, forum_category_2].to_json)
      end
    end
  end

  describe '#show' do
    context 'with no categories' do
      it 'returns an error message' do
        get :show, params: { id: 7 }

        expect(response.body).to include('Category does not exist')
        expect(response.status).to eq(404)
      end
    end

    context 'with 2 categories' do
      let(:forum_category_1) { ForumCategory.create(title: 'Test Category 1') }
      let(:forum_category_2) { ForumCategory.create(title: 'Test Category 2') }

      it 'returns 1 category' do
        get :show, params: { id: forum_category_2.id }

        expect(JSON.parse(response.body)['title']).to eq('Test Category 2')
      end
    end

    context 'with no threads' do
      let(:forum_category_1) { ForumCategory.create(title: 'Test Category 1') }

      it 'returns an empty array' do
        get :show, params: { id: forum_category_1.id }

        expect(JSON.parse(response.body)['forum threads']).to eq(nil)
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
        get :show, params: { id: forum_category_1.id }

        expect(JSON.parse(response.body)['forum_threads'].first['title']).to eq('Testthread1')
      end
    end
  end

  describe '#update' do
    let(:forum_category_1) { ForumCategory.create(title: 'Test category title') }
    context 'with no data' do

      it 'returns an error messge' do
        post :update, params: { id: forum_category_1.id, forum_category: {} }

        expect(response.body).to include('No forum category details provided')
        expect(response.status).to eq(422)
      end
    end

    context 'with invalid data' do
      it 'returns an error message' do
        post :update, params: { id: forum_category_1.id, forum_category: { title: '' } }

        expect(response.body).to include('Please fill in a category title')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid data' do
      it 'returns the updated category' do
        post :update, params: { id: forum_category_1.id, forum_category: { title: 'New category title' } }

        expect(JSON.parse(response.body)['title']).to eq('New category title')
      end
    end
  end

  describe '#destroy' do
    context 'with no categories' do
      it 'returns an error message' do
        delete :destroy, params: { id: 5 }

        expect(response.body).to include('Category does not exist')
        expect(response.status).to eq(404)
      end
    end

    context 'with 2 categories' do
      let(:forum_category_1) { ForumCategory.create(title: 'Test Category 1') }
      let(:forum_category_2) { ForumCategory.create(title: 'Test Category 2') }
      before do
        forum_category_1
        forum_category_2
      end
      
      it 'destroys 1 category' do
        delete :destroy, params: { id: forum_category_2.id }

        expect(ForumCategory.count).to eq(1)
      end
    end
  end
end
