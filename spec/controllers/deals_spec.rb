require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  before do
    @user = create(:user)
    @category = create(:category)
    @deals = create_list(:deal, 3, category: @category, user: @user)
  end

  context 'when authenticated' do
    before { sign_in @user }

    it 'returns a successful response with category deals' do
      get :index, params: { category_id: @category.id }
      expect(response).to have_http_status(200)
      expect(assigns(:deals)).to eq(@deals)
    end

    it 'orders deals by created_at ascending' do
      deals = create_list(:deal, 5, category: @category)
      get :index, params: { category_id: @category.id }
      expect(assigns(:deals).pluck(:created_at)).to eq(deals.pluck(:created_at).sort)
    end
  end

  context 'when not authenticated' do
    it 'redirects to the login page' do
      get :index, params: { category_id: @category.id }
      expect(response).to redirect_to new_user_session_path
    end
  end

  it 'returns a successful response for new deal' do
    sign_in @user
    get :new, params: { category_id: @category.id }
    expect(response).to have_http_status(200)
    expect(assigns(:deal)).to be_a_new(Deal)
    expect(assigns(:deal).category).to eq(@category)
  end

  context 'with valid params' do
    it 'creates a new deal and redirects' do
      sign_in @user
      expect do
        post :create, params: { category_id: @category.id, deal: { name: 'Test Deal', amount: 100 } }
      end.to change(Deal, :count).by(1)
      expect(response).to redirect_to user_category_deals_path(@user, @category)
    end
  end

  context 'with invalid params' do
    it 'renders the new template' do
      sign_in @user
      post :create, params: { category_id: @category.id, deal: { name: '' } }
      expect(response).to render_template :new
    end
  end

  context 'with valid params' do
    it 'updates the deal and redirects' do
      sign_in @user
      patch :update, params: { id: @deal.id, deal: { amount: 200 } }
      expect(@deal.reload.amount).to eq(200)
      expect(response).to redirect_to @deal
    end
  end

  context 'with invalid params' do
    it 'renders the edit template' do
      sign_in @user
      patch :update, params: { id: @deal.id, deal: { name: '' } }
      expect(response).to render_template :edit
    end
  end

  it 'destroys the deal and redirects' do
    sign_in @user
    expect do
      delete :destroy, params: { id: @deal.id }
    end.to change(Deal, :count).by(-1)
    expect(response).to redirect_to deals_path
  end
end
