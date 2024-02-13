require 'rails_helper'

RSpec.describe Deal, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User').with_foreign_key('author_id') }
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  describe 'creation' do
    context 'with valid attributes' do
      let(:deal) { build(:deal, name: 'Test Deal', amount: 50, user: user, category: category) }

      it 'is valid' do
        expect(deal).to be_valid
      end
    end

    context 'with invalid attributes nameless' do
      let!(:deal) { build(:deal, name: '', amount: 50, user: user, category: category) }
      it 'is not valid without a name' do
        expect(deal).not_to be_valid
        expect(deal.errors[:name]).to include("can't be blank")
      end
    end
    
    context 'with invalid attributes no amount' do
      let!(:deal) { build(:deal, name: 'Test Deal', amount: '', user: user, category: category) }
      it 'is not valid without an amount' do
        expect(deal).not_to be_valid
        expect(deal.errors[:amount]).to include("can't be blank")
      end
    end
      
    context 'with invalid attributes negative amount' do
      it 'is not valid with a negative amount' do
        deal = build(:deal, name: 'Test Deal', amount: -10, user: user, category: category)
        expect(deal).not_to be_valid
        expect(deal.errors[:amount]).to include('must be greater than or equal to 0')
      end
    end
  end
end
