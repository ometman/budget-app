require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  before do
    @user = create(:user, id: 92)
    @category = create(:category, id: 99, user: @user)
    @deals = create(:deal, id: 999, category: @category, author_id: @user.id)
  end

  describe 'when authenticated' do
    it 'returns a successful response with category deals' do
      sign_in @user
      get :index, params: { user_id: @user.id, category_id: @category.id }
      expect(response).to have_http_status(200)
      # expect(assigns(:deals)).to eq(@deals)
    end

    it 'orders deals by created_at ascending' do
      sign_in @user
      create(:deal, id: 9999, category: @category, author_id: @user.id)
      get :index, params: { user_id: @user.id, category_id: @category.id }
      expect(assigns(:deals).first.created_at).to be <= assigns(:deals).last.created_at
    end

    it 'when not authenticated redirects to the login page' do
      get :index, params: { user_id: @user.id, category_id: @category.id }
      expect(response).to redirect_to new_user_session_path
    end

    it 'returns a successful response for new deal' do
      sign_in @user
      get :new, params: { user_id: @user.id, category_id: @category.id }
      expect(response).to have_http_status(200)
      expect(assigns(:deal)).to be_a_new(Deal)
      expect(assigns(:deal).category).to eq(@category)
    end

    it 'returns a successful response for association with category' do
      sign_in @user
      get :new, params: { user_id: @user.id, category_id: @category.id }
      expect(assigns(:deal).category).to eq(@category)
    end
  end

  describe 'create a deals' do
    context 'with valid params' do
      it 'creates a new deal and redirects' do
        sign_in @user
        expect do
          post :create, params: { user_id: @user.id, category_id: @category.id, deal: { name: 'Test Deal', amount: 100, category_ids: [@category.id] } }
        end.to change(Deal, :count).by(1)
        expect(response).to redirect_to user_category_deals_path(@user, @category)
      end
    end
  
    context 'with invalid params' do
      it 'renders the new template' do
        sign_in @user
        post :create, params: { user_id: @user.id, category_id: @category.id, deal: { name: '', category_ids: [@category.id] } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DESTROY #destroy' do
    it 'destroys the deal and redirects' do
      sign_in @user
      expect do
        delete :destroy, params: { user_id: @user.id, category_id: @category.id, id: @deals.id }
      end.to change(Deal, :count).by(-1)
      expect(response).to redirect_to user_category_deals_path(@user, @category)
    end
  end
end