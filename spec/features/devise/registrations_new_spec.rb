require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario "User visits sign up page" do
    visit new_user_registration_path

    expect(page).to have_content("REGISTER")
    expect(page).to have_field("Email", type: "email")
    expect(page).to have_field("Password", type: "password")
    expect(page).to have_link('arrow_back', href: root_path)
    expect(page).to have_link(text: 'Next')
    expect(page).to have_selector('input[type="submit"].signup-submit', visible: :hidden)
  end
  
  scenario 'with valid credentials, redirects to root' do
    @user = create(:user, email: 'user@example.com', password: 'password')

    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    execute_script("document.getElementById('signup-form').submit();")

    expect(page).to have_current_path(user_registration_path)
  end

end
