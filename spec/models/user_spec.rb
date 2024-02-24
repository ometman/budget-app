require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }

    it { should validate_presence_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('user@example').for(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }

    # reset_password_sent_at and case sensitivity tested below
  end

  describe 'associations' do
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:deals).through(:categories).dependent(:destroy) }
  end

  describe 'creating a user' do
    it 'creates a valid user' do
      user = create(:user)
      expect(user).to be_valid
    end

      it 'has no categories when created' do
      user = create(:user)
      expect(user.categories).to be_empty
    end
  end

  describe 'factory' do
    it 'validates uniqueness of email case-insensitively' do
      email = 'test@example.com'
      create(:user, email: email.upcase) # Create a user with uppercase email
      user = build(:user, email: email.downcase) # Build a user with lowercase email

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end
  end
end
