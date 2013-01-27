require 'spec_helper'

describe 'Signing Up' do
  describe 'Successful sign up' do
    When  do
      visit '/'
      click_link 'sign up'
      fill_in "Email", with: "test@test.com"
      fill_in "user_password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign up"
    end

    Then do
      message = "Please open the link to activate your account."
      page.should have_content(message)
    end
  end
end
