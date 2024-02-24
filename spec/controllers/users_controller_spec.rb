require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      @user1 = create(:user, id: 1)
      @user2 = create(:user, id: 2)
    end

    it 'when authenticated redirects to user categories path' do
      sign_in @user1
      get :index
      expect(response).to redirect_to user_categories_path(@user1)
    end

    it 'when unauthenticated redirects to new_user_session_path' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #show' do
    non_existent_user_id = 999

    before do
      @user = create(:user, id: 1)
      @categories = create_list(:category, 3, user_id: @user.id)
    end

    it 'renders a 404 error for non-existent user' do
      sign_in @user
      get :show, params: { id: non_existent_user_id }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to be_empty
    end

    it 'existing user found by id' do
      sign_in @user
      get :show, params: { id: @user.id }
      current_user = assigns(:user)
      expect(current_user).to eq(@user)
    end

    it 'existing user gets categories assigned' do
      sign_in @user
      get :show, params: { id: @user.id }
      expect(assigns(:categories)).to eq(@user.categories)
    end

    it 'non-existent user renders 404' do
      sign_in @user
      get :show, params: { id: 123 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    context 'when authorized user destroys their own account' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'destroys user and redirects to root_path' do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('User was successfully deleted.')
      end
    end

    context 'when unauthorized user attempts to destroy another user' do
      before do
        @user1 = create(:user)
        @user2 = create(:user)
        sign_in @user1
      end

      it 'renders 403 Forbidden' do
        delete :destroy, params: { id: @user2.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
