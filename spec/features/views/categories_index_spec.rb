require 'rails_helper'

feature 'Categories page', js: true do
  
  scenario 'New user has no categories' do
    @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

    visit '/auth/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    execute_script("document.getElementById('login-form').submit();")

    within('.categories-container') do
      expect(page).to have_css('.category-container', count: 0)
    end

    expect(page).to have_content('No categories available')
    expect(page).to have_link('Add a new category')
  end

  scenario 'User views categories created' do
    @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

    visit '/auth/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    
    execute_script("document.getElementById('login-form').submit();")

   # Create a category associated with the user
   category = create(:category, user_id: @user.id)

    within('.categories-container') do
      expect(page).to have_selector('div.category-container', count: 1)
    end

    expect(page).to have_selector('h2.cat-name', text: category.name)
    expect(page).to have_selector('p.cat-date', text: category.created_at)
    expect(page).to have_selector('span.cat-total-amt', text: category.deals.sum(:amount))  
  end
end
