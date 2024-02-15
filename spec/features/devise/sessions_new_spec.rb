# spec/features/session_spec.rb

require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "User visits login page" do
    visit new_user_session_path

    # Check if the page contains necessary elements
    expect(page).to have_content("LOGIN")
    expect(page).to have_field("Email", type: "email")
    expect(page).to have_field("Password", type: "password")
    expect(page).to have_button("Log in")
  end

  scenario "User can login with valid credentials" do
    user = create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password" # Assuming default password is "password"
    click_button "Log in"

    # After successful login, user should be redirected to the root path or other path based on your application logic
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Hello, #{user.name}!")
  end

  scenario "User cannot login with invalid credentials" do
    visit new_user_session_path

    fill_in "Email", with: "invalid_email@example.com"
    fill_in "Password", with: "invalid_password"
    click_button "Log in"

    # After unsuccessful login attempt, user should stay on the login page with an error message
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("Invalid Email or password")
  end
end
