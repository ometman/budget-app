require 'rails_helper'

RSpec.feature "Viewing a Category", type: :feature do
  scenario "User views details of a category with transactions" do
    # Create test data: a user, a category, and deals associated with the category
    user = create(:user)
    category = create(:category, user: user)
    deals = create_list(:deal, 3, category: category)

    # Visit the category show page
    visit user_category_path(user, category)

    # Expectations: Check if the category details and deals are displayed correctly
    expect(page).to have_text("Total Amount:")
    expect(page).to have_text(category.deals.sum(:amount))

    deals.each do |deal|
      expect(page).to have_text(deal.name)
      expect(page).to have_text(deal.amount)
    end

    expect(page).to have_link("Add a New Transaction", href: new_user_category_deal_path(user, category))
    expect(page).to have_link("Back to Categories", href: user_categories_path(user))
    expect(page).to have_button("SCAN")
  end

  scenario "User views category with no transactions available" do
    # Create test data: a user and a category with no deals
    user = create(:user)
    category = create(:category, user: user)

    # Visit the category show page
    visit user_category_path(user, category)

    # Expectations: Check if the no transactions available message is displayed
    expect(page).to have_text("No transactions available")
  end
end
