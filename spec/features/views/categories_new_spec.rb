# require 'rails_helper'

# RSpec.feature 'Categories Page' do

#   scenario 'User can create new category' do
#     @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

#     visit new_user_session_path
#     fill_in 'Email', with: @user.email
#     fill_in 'Password', with: @user.password
#     execute_script("document.getElementById('login-form').submit();")

#     # visit user_categories_path(user)

#     expect(page).to have_css('header.categories h1', text: 'Categories')

#     within('.header-cat-links') do
#       expect(page).to have_link('Most recent', href: user_categories_path(@user, recent: true))
#       expect(page).to have_link('Most oldest', href: user_categories_path(@user, oldest: true))
#     end

#     within('.category-actions') do
#       expect(page).to have_link('SAVE')
#     end

#     within('.categories-container') do
#       expect(page).to have_selector('form#new-category-save-btn.new-category-form')

#       within('.categories-form-container') do
#         expect(page).to have_selector('h2.categories-heading', text: 'Add a New Category')

#         expect(page).to have_field('Name')
#         expect(page).to have_field('category_icon')
#       end
#     end

#     expect(page).to have_link('Back to Categories', href: user_categories_path(@user), class: 'back-link')
#   end
# end


require 'rails_helper'

RSpec.feature 'Categories Page' do

  scenario 'User can create a new category' do
    @user = create(:user, id: 99, email: 'user@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    execute_script("document.getElementById('login-form').submit();")

    # Ensure you're redirected to the user categories page after login
    # visit user_categories_path(@user)

    expect(page).to have_css('header.categories h1', text: 'Categories')
    expect(page).to have_css('.header-title h1', text: 'Categories')

    within('.header-cat-links') do
      expect(page).to have_link('Most recent', href: user_categories_path(@user, recent: true))
      expect(page).to have_link('Most oldest', href: user_categories_path(@user, oldest: true))
    end

    within('.categories-container') do
      expect(page).to have_css('.category-container', count: 0)
    end

    expect(page).to have_content('No categories available')
    expect(page).to have_link('Add a new category')

    click_link('Add a new category')

    expect(page).to have_content('Add a New Category')

    # Updated selector for form container
    within('.categories-container') do
      expect(page).to have_selector('form#new-category-save-btn')
    end
    within('.categories-form-container') do
      expect(page).to have_field('Name')
      expect(page).to have_field('category_icon')
    end

    # Check presence of Back to Categories link
    expect(page).to have_link('Back to Categories', href: user_categories_path(@user), class: 'back-link')


      # Updated selector for SAVE button
    within('.category-actions') do
      expect(page).to have_link('SAVE')
    end

    fill_in 'Name', with: 'Test Category'
    attach_file('category_icon', Rails.root.join('spec', 'fixtures', 'images', 'test_icon.jpeg')) # Adjust path and data accordingly
   
    execute_script("document.getElementById('new-category-save-btn').submit();")

    expect(page).to have_current_path(user_categories_path(@user))
  end
end
