require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    let!(:user) { User.create(username: 'Testusername', email: 'test91@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password', admin: false) }

    before { user.create_reset_digest }

    it "returns http success" do
      get :edit, params: { email: user.email, id: 'lols' }
      expect(response).to have_http_status(:success)
    end
  end
end
