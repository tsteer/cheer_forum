require 'rails_helper'

RSpec.describe 'users/index' do
  context 'with 2 users, as an admin' do
    let(:user_1) { User.create(username: 'User name 1', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_2) { User.create(username: 'User name 2', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }
    let(:user_3) { User.create(username: 'User name 3', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: true) }

    before do
      user_1
      user_2
      user_3
      allow(view).to receive(:current_user).and_return(:user_3)
    end

    it 'displays 2 users' do
      assign(:users, [user_1, user_2, user_3])

      render

      expect(rendered).to match /User name 1/
      expect(rendered).to match /User name 2/
      expect(rendered).to match /User name 3/
    end
  end
end
