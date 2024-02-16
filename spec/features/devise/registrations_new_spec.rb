require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario "User visits sign up page" do
    visit new_user_registration_path

    expect(page).to have_content("REGISTER")
    expect(page).to have_field("Email", type: "email")
    expect(page).to have_field("Password", type: "password")
    expect(page).to have_link('arrow_back', href: root_path)
    expect(page).to have_selector('a.login-btn-text', text: 'Next')
    expect(page).to have_selector('input[type="submit"].signup-submit', visible: :hidden)
  end
  
  scenario 'with valid credentials, redirects to user categories page' do
    @user = create(:user, email: 'user@example.com', password: 'password')

    visit new_user_registration_path

    # Fill in registration fields
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    execute_script("document.getElementById('signup-form').submit();")

    # Assert redirection to user categories page
    expect(page).to have_current_path(user_categories_path(@user))
  end

  scenario 'with empty fields, shows error messages' do
    visit new_user_registration_path

    click_link('Next')

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'with invalid email format, shows error message' do
    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'invalid_email'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    click_link('Next')
    expect(page).to have_content("Email is invalid")
  end

  scenario 'with password mismatch, shows error message' do
    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'wrong_password'

    click_link('Next')

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
