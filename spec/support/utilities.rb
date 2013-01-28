RSpec::Matchers.define :show_menu do
  match do |page|
    page.should have_selector('nav#main_nav')
    page.should have_link('home', href: root_path)
    page.should have_link('course', href: course_path("medial-operations"))
    page.should have_link('syllabus', href: syllabus_path)
    page.should have_link('sign up', href: new_user_registration_path)
    page.should have_link('sign in', href: new_user_session_path)
  end
end
