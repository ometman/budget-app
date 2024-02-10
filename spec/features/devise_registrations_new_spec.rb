require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario 'User signs up with valid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_text('Welcome, Test User!')
  end

  scenario 'User fails to sign up with invalid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: '' # Blank name
    fill_in 'Email', with: 'invalid-email' # Invalid email format
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'different_password'

    click_button 'Sign up'

    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_text('errors prohibited this user from being saved')
  end
end
