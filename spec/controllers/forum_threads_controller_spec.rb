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
end
