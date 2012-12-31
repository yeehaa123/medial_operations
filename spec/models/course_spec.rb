require 'spec_helper'

describe Course do

  Given(:course) { build(:course) }

  subject { course }

  it  { should have_fields :title, :title_prefix, :description, :requirements,
                           :prerequisites }

  it  { should have_many :sections }
  it  { should have_many :meetings }
  it  { should have_many :assignments }
  it  { should have_and_belong_to_many :references }

  it { should validate_presence_of :title }

  it { should be_valid }

  its(:to_s) { should == "#{ course.title }" }

  describe "create_course" do
    Given(:course) do 
      Course.create_course "Prefix: New Course" do
        course_description "Course Description"
        course_requirements "Course Requirements"
        meeting "Introduction" do
        end
        section "1 - New Section" do
          meeting "Lecture" do
          end
        end
        section "2 - New Section" do
          meeting "Seminar" do
          end
        end
        section "3 - New Section" do
        end
        meeting "Closing Session" do
        end
      end
    end


    Then  { expect(course.title_prefix).to eq "Prefix" }
    And   { expect(course.title).to eq "New Course" }
    And   { expect(course.description).to eq "Course Description" } 
    And   { expect(course.requirements).to eq "Course Requirements" } 
  
    describe "sections" do
      Given(:section) { course.sections.first }
      
      Then  { expect(course.sections.size).to eq 3 }
      And   { expect(section.course).to eq course }
    end
    
    describe "sessions" do
      Given(:meeting) { course.meetings.first }
      
      Then  { expect(course.meetings.size).to eq 4 }
      And   { expect(meeting.course).to eq course }
    end

    And   { course.should be_valid }
    And   { course.should be_persisted }
  end
end
