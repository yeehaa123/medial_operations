require 'spec_helper'

describe 'Signing in' do
  Given { create(:user, email: "test@example.com") }

  describe 'Signing in via confirmation' do
    When do
      open_email "test@example.com", with_subject: /Confirmation/
      click_first_link_in_email
    end
    
    Then  { page.should have_content("Your account was successfully confirmed") }
    And   { page.should have_content("You are now signed in.") }
  end

  describe 'Signing in via form' do
    When do
      User.find_by(email: 'test@example.com').confirm!
      visit '/'
      click_link 'sign in'
      fill_in 'Email', with: "test@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign in"
    end

    Then  { page.should have_content("Signed in successfully.") }
    And   { page.should have_link("sign out") }
    And   { page.should_not have_link("sign in") }
    And   { page.should_not have_link("sign up") }

    describe 'Signing out' do
      When { click_link 'sign out' }
      Then  { page.should have_content("Signed out successfully.") }
      And   { page.should have_link("sign in") }
      And   { page.should have_link("sign up") }
      And   { page.should_not have_link("sign out") }
    end
  end
end
