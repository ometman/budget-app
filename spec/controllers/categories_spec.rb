require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: { name: 'New Category' } }
        end.to change(Category, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: { name: '' } }
        end.not_to change(Category, :count)
        expect(response).to redirect_to(new_category_path)
        expect(flash[:alert]).to be_present
      end
    end    
  end
end
