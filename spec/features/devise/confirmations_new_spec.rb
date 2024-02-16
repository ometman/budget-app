require 'rails_helper'

RSpec.feature 'Resend confirmation instructions', type: :feature do
  scenario 'User requests to resend confirmation instructions' do
    # Create a user with unconfirmed email
    user = create(:user, :unconfirmed)

    # Visit the resend confirmation page
    visit new_user_confirmation_path

    # Fill in the email field
    fill_in 'Email', with: user.email

    # Click the "Resend confirmation instructions" button
    click_link('Next')
    execute_script("document.getElementById('login-form').submit();")
    # Expectations: Check for success flash message or any other indication of success
    expect(page).to have_text('confirm your email address')
    
    expect(page).to have_current_path(new_user_session_path)
  end
end
