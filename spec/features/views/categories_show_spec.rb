require 'rails_helper'

RSpec.feature 'Viewing a Category', type: :feature do
  scenario 'No transaction in new category created' do
    @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    execute_script("document.getElementById('login-form').submit();")

    expect(page).to have_current_path(user_categories_path(@user))

    @category = create(:category, id: 999, user_id: @user.id)

    visit user_category_path(@user, @category, user_id: @user.id, id: @category.id)

    expect(page).to have_content('No transactions available')
  end

  scenario 'User views details of new category  and transaction' do
    @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    execute_script("document.getElementById('login-form').submit();")

    expect(page).to have_current_path(user_categories_path(@user))

    @category = create(:category, id: 999, user_id: @user.id)
    expect(page).to have_link('Add a new category')

    visit user_category_path(@user, @category, user_id: @user.id, id: @category.id)

    # Create test data: a user, a category, and deals associated with the categor
    expect(page).to have_link('Add a New Transaction')
    expect(page).to have_link('Back to Categories')

    click_link('Add a New Transaction')

    expect(page).to have_link('SAVE')
    @deal = create(:deal, id: 9999, author_id: @user.id, category_id: @category.id)

    visit user_category_path(@user, @category, user_id: @user.id, id: @category.id)
    expect(page).to have_text('Total Amount:')
    expect(page).to have_content(@deal.amount)
  end
end
