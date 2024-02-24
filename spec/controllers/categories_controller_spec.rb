require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'when authenticated' do
      before do
        @user = create(:user, id: 1)
        3.times do |i|
          create(:category, user: @user, created_at: Time.now - i.days)
        end
      end

      it 'returns a success response' do
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(response).to be_successful
      end

      it 'returns the current user\'s categories' do
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(assigns(:categories)).to eq(@user.categories)
      end

      it 'orders categories by created_at (descending by default)' do
        sign_in @user
        get :index, params: { user_id: @user.id, recent: true }
        expect(assigns(:categories).first.created_at).to be >= assigns(:categories).last.created_at
      end

      it 'orders categories by created_at ascending when `oldest` param is present' do
        sign_in @user
        get :index, params: { user_id: @user.id, oldest: true }
        expect(assigns(:categories).first.created_at).to be >= assigns(:categories).last.created_at
      end

      it 'when not authenticated redirects to login page' do
        get :index, params: { user_id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    before do
      @user = create(:user, id: 1)
      sign_in @user
      3.times do |i|
        create(:category, user: @user, created_at: Time.now - i.days)
      end
    end

    it 'with valid attributes creates a new category' do
      expect do
        post :create, params: { user_id: @user.id, category: { name: 'New Category' } }
      end.to change(Category, :count).by(1)
      expect(response).to redirect_to user_categories_path(user_id: @user.id)
      expect(flash[:notice]).to be_present
    end

    it 'invalid attributes does not create a new category' do
      expect do
        post :create, params: { user_id: @user.id, category: { name: '' } }
      end.not_to change(Category, :count)
      expect(response).to render_template :new
      expect(flash[:alert]).to be_present
    end
  end
end