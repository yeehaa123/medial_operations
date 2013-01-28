require 'spec_helper'

describe "User Pages" do
  Given(:user) { create(:user) }

  describe "sign up page" do
    When { visit new_user_registration_path }

    Then  { page.should have_selector('h2', text: "Sign up") }
    And   { page.should have_selector('input#user_first_name') }
    And   { page.should have_selector('input#user_last_name') }
    And   { page.should have_selector('input#user_student_number') }
    And   { page.should have_selector('input#user_email') }
    And   { page.should have_selector('input#user_password') }
    And   { page.should have_selector('input#user_password_confirmation') }
  end

  describe "sign up page" do
    When { visit new_user_session_path }

    Then  { page.should have_selector('h2', text: "Sign in") }
    And   { page.should have_selector('input#user_email') }
    And   { page.should have_selector('input#user_password') }
  end

  describe "profile page" do
    When { visit user_path(user) }

    Then { page.should have_selector('h1', text: user.name) }
    Then { page.should have_selector('p', text: user.email) }
  end
end
