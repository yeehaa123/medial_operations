require 'spec_helper'

describe Assignment do
  Given(:assignment) { build(:assignment) }
  
  subject { assignment }

  it { should be_timestamped_document }

  it  { should have_fields :title, :description, :deadline, :number }

  it  { should belong_to :section }

  it  { should validate_presence_of :course }

  it  { should be_valid }
  
  its(:to_s) { should == "#{ assignment.title }" }

  describe "only assign sections belonging to right course" do
    Given(:assignment)    { build(:assignment_with_section) }
    Given(:other_course)  { Course.new }
    
    When { assignment.course = other_course }

    Then { assignment.should_not be_valid }
    Then { assignment.should have(1).error_on(:section) }
  end
end
