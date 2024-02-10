require 'rails_helper'

RSpec.feature "Viewing categories", type: :feature do
  scenario "User views list of categories" do
    # Create test data: a user and categories
    user = create(:user)
    categories = create_list(:category, 3, user: user)

    # Visit the categories index page
    visit user_categories_path(user)

    # Expectations: Check if the categories are displayed correctly
    expect(page).to have_text("Total Amount")
    expect(page).to have_text("Add a new category")

    categories.each do |category|
      expect(page).to have_text(category.name)
      expect(page).to have_text(category.created_at)
      expect(page).to have_text(category.deals.sum(:amount))
    end
  end

  scenario "User views no categories available message" do
    # Create a user with no categories
    user = create(:user)

    # Visit the categories index page
    visit user_categories_path(user)

    # Expectations: Check if the no categories available message is displayed
    expect(page).to have_text("No categories available")
  end
end
