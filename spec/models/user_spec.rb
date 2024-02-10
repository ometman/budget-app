require 'rails_helper'
require_relative '../factories/user'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) } 
    it { should_not allow_value('user@example').for(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }
  end

  describe "associations" do
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:deals).through(:categories).dependent(:destroy) }
  end
  
  describe "Devise modules" do
    let!(:user) { create(:user, **default_user_attributes) }
    def default_user_attributes
      {
        name: '',
        email: '',
        password: '',
      }
    end
        
    it { should respond_to(:database_authenticatable?) }
    it { should respond_to(:registerable?) }
    it { should respond_to(:recoverable?) }
    it { should respond_to(:rememberable?) }
    it { should respond_to(:validatable?) }
    it { should respond_to(:confirmable?) }
  end

    it "creates a valid user" do
      user = create(:user)
      expect(user).to be_valid
    end

    it "responds to database_authenticatable?" do
      user = create(:user)
      expect(user.database_authenticatable?).to be_truthy
    end

    it "creates a confirmed user" do
      user = create(:user, :confirmed)
      expect(user).to be_confirmed
    end
  end
end