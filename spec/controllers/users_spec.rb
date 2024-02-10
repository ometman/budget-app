require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns all users to @users" do
      user1 = create(:user)
      user2 = create(:user)
      get :index
      expect(assigns(:users)).to eq([user1, user2])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested user to @user" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end

    it "does not create a new user" do
      expect {
        post :create
      }.to_not change(User, :count)
    end
  end
end
