require 'spec_helper'

describe "CoursePages" do
  let(:base_title)  { "Medial Operations" }
  let(:course)      { create(:defined_course) }

  subject { page }

  context "course show page" do 
    
    before { visit course_path(course) }

    it { should have_selector('title', text: "#{ base_title }") }
    it { should show_menu }
    it { should have_selector('hgroup.course_title') }
    it { should have_selector('section.course_description') }
    it { should_not have_selector('section.sections') }
    it { should_not have_selector('section.meetings') }
  end

  context "syllabus" do
      
    before { visit syllabus_course_path(course) }

    it { should have_selector('title', text: "#{ base_title }") }
    it { should show_menu }
    it { should have_selector('hgroup.course_title') }
    it { should have_selector('section.course_description') }
    it { should have_selector('section.section', count: 3) }
    it { should have_selector('section.meeting', count: 10) }
  end

  context "course section pages" do
    let(:section) { course.sections.first }

    before { visit course_section_path(course, section) }

    it { should have_selector('title', text: "#{ base_title }") }
    it { should show_menu }
    it { should have_selector('section.section', count: 1) }
    it { should have_selector('section.meeting', count: 3) }
  end

  context "course section pages" do
    let(:meeting) { course.meetings.first }

    before { visit course_meeting_path(course, meeting) }

    it { should have_selector('title', text: "#{ base_title }") }
    it { should show_menu }
    it { should have_selector('section.meeting', count: 1) }
  end
end
