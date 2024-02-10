require 'rails_helper'

RSpec.describe Deal, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  describe 'associations' do
    it { should belong_to(:user).class_name('User').with_foreign_key('author_id') }
    it { should have_and_belong_to_many(:categories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  describe 'creation' do
    it 'is valid with valid attributes' do
      deal = user.deals.build(name: 'Test Deal', amount: 50)
      expect(deal).to be_valid
    end

    it 'is not valid without a name' do
      deal = user.deals.build(amount: 50)
      expect(deal).not_to be_valid
      expect(deal.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an amount' do
      deal = user.deals.build(name: 'Test Deal')
      expect(deal).not_to be_valid
      expect(deal.errors[:amount]).to include("can't be blank")
    end

    it 'is not valid with a negative amount' do
      deal = user.deals.build(name: 'Test Deal', amount: -10)
      expect(deal).not_to be_valid
      expect(deal.errors[:amount]).to include('must be greater than or equal to 0')
    end
  end
end
