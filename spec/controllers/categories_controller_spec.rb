 require 'rails_helper'


#   describe 'GET #index' do
#     it 'returns a success response' do
#       get :index
#       expect(response).to be_successful
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid attributes' do
#       it 'creates a new category' do
#         expect do
#           post :create, params: { category: { name: 'New Category' } }
#         end.to change(Category, :count).by(1)
#       end
#     end

#     context 'with invalid attributes' do
#       it 'does not create a new category' do
#         expect do
#           post :create, params: { category: { name: '' } }
#         end.not_to change(Category, :count)
#         expect(response).to redirect_to(new_category_path)
#         expect(flash[:alert]).to be_present
#       end
#     end    
#   end
# end

RSpec.describe CategoriesController, type: :controller do

  describe 'GET #index' do
    context 'when authenticated' do
      before do
        sign_in create(:user)
      end

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end

      it 'returns the current user's categories' do
        category = create(:category, user: @user)
        get :index
        expect(assigns(:categories)).to include(category)
      end

      it 'orders categories by created_at (descending by default)' do
        # Create categories with different creation times
        time1 = Time.now - 1.day
        time2 = Time.now
        create(:category, user: @user, created_at: time1)
        create(:category, user: @user, created_at: time2)
        get :index
        expect(assigns(:categories).first.created_at).to be >= assigns(:categories).last.created_at)
      end

      it 'orders categories by created_at ascending when `oldest` param is present' do
        # Create categories with different creation times
        time1 = Time.now - 1.day
        time2 = Time.now
        create(:category, user: @user, created_at: time1)
        create(:category, user: @user, created_at: time2)
        get :index, params: { oldest: true }
        expect(assigns(:categories).first.created_at).to be <= assigns(:categories).last.created_at)
      end
    end

    context 'when not authenticated' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: { name: 'New Category' } }
        end.to change(Category, :count).by(1)
        expect(response).to redirect_to user_categories_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: { name: '' } }
        end.not_to change(Category, :count)
        expect(response).to render_template :new
        expect(flash[:alert]).to be_present
      end
    end
  end
end
