require 'rails_helper'

feature 'Login page' do
  scenario 'User visits login page' do
    visit new_user_session_path

    expect(page).to have_content('LOGIN')
    expect(page).to have_field('Email', type: 'email')
    expect(page).to have_field('Password', type: 'password')
    expect(page).to have_link('arrow_back', href: root_path)
    expect(page).to have_selector('a.login-btn-text', text: 'Next')
    expect(page).to have_selector('input[type="submit"].login-submit', visible: :hidden)
  end

  scenario 'with valid credentials, redirects to user categories page' do
    @user = create(:user, email: 'user@example.com', password: 'password')

    visit '/auth/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    expect(page).to have_link(text: 'Next')
    expect(page).to have_selector('#login-form')

    click_link('Next')
    expect(page).to have_current_path(user_categories_path(@user))
  end

  scenario 'with invalid credentials, shows error message' do
    visit '/auth/login'

    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrong_password'
    click_link('Next')
    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with empty email and password, shows error messages' do
    visit '/auth/login'

    # No need to fill in fields
    execute_script("document.getElementById('login-form').submit();")
    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with only email, shows error message' do
    visit '/auth/login'
    fill_in 'Email', with: 'user@example.com'
    execute_script("document.getElementById('login-form').submit();")
    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with only password, shows error message' do
    visit '/auth/login'
    fill_in 'Password', with: 'password'
    execute_script("document.getElementById('login-form').submit();")
    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with incorrect email, shows error message' do
    visit '/auth/login'
    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'password'
    execute_script("document.getElementById('login-form').submit();")
    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with incorrect password, shows error message' do
    @user = create(:user, email: 'user@example.com', password: 'password')

    visit '/auth/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'wrong_password'
    execute_script("document.getElementById('login-form').submit();")
    expect(page).to have_content('Invalid Email or password')
  end
end
