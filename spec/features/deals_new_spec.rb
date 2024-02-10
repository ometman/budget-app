require 'rails_helper'

RSpec.feature 'Viewing a Deal', type: :feature do
  scenario 'User views details of a deal' do
    # Create test data: a user, a category, and a deal
    user = create(:user)
    category = create(:category, user:)
    deal = create(:deal, category:)

    # Visit the deals show page
    visit user_category_deal_path(user, category, deal)

    # Expectations: Check if the deal details are displayed correctly
    expect(page).to have_text('Deal Details')
    expect(page).to have_text("Name: #{deal.name}")
    expect(page).to have_text("Amount: #{deal.amount}")
    expect(page).to have_text("Category: #{category.name}")
  end
end
