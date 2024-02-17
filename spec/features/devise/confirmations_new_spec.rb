require 'rails_helper'

RSpec.feature 'Resend confirmation instructions', type: :feature do
  scenario 'User requests resend with unconfirmed email' do
    # Create a user with unconfirmed email
    create(:user, email: 'user@example.com', password: 'password', confirmed_at: nil)

    visit new_user_confirmation_path

    within('.signup-container') do
      expect(page).to have_field('Email', type: 'email')
      expect(page).to have_selector('input[type="submit"].signup-submit', visible: :hidden)
    end

    fill_in 'Email', with: 'user@example.com'
    execute_script("document.getElementById('confirmation-form').submit();")

    expect(page).to have_content('You will receive an email with instructions for how to confirm your email address in a few minutes.')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User requests resend with confirmed email' do
    create(:user, email: 'user@example.com', password: 'password', confirmed_at: Time.current)

    visit new_user_confirmation_path

    within('.signup-container') do
      expect(page).to have_field('Email', type: 'email')
      expect(page).to have_selector('input[type="submit"].signup-submit', visible: :hidden)
    end

    fill_in 'Email', with: 'user@example.com'
    execute_script("document.getElementById('confirmation-form').submit();")

    expect(page).to have_content('Email was already confirmed, please try signing in')
    expect(page).to have_current_path(user_confirmation_path)
  end
end
