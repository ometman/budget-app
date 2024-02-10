require 'rails_helper'

RSpec.feature "Login", type: :feature do
  scenario "User logs in with valid credentials" do
    # Create a user
    user = create(:user, email: "user@example.com", password: "password")

    # Visit the login page
    visit new_user_session_path

    # Fill in the login form
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"

    # Submit the form
    click_button "Log in"

    # Expect to be redirected to the dashboard or another page indicating successful login
    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_text("Welcome, #{user.email}!")
  end

  scenario "User fails to log in with invalid credentials" do
    # Visit the login page
    visit new_user_session_path

    # Fill in the login form with invalid credentials
    fill_in "Email", with: "invalid@example.com"
    fill_in "Password", with: "invalidpassword"

    # Submit the form
    click_button "Log in"

    # Expect to stay on the login page and see a flash message indicating login failure
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text("Invalid email or password.")
  end
end
