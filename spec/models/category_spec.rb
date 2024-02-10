# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should belong_to(:user).dependent(:destroy) }
    it { should have_many(:deals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }
  end

  describe 'default scope' do
    it 'orders categories by name in ascending order' do
      category1 = create(:category, name: 'Category B')
      category2 = create(:category, name: 'Category A')
      expect(Category.all).to eq([category2, category1])
    end
  end
end
