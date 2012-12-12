require 'spec_helper'
  
describe Tag do

  Given(:tag)       { create(:tag) }
  Given(:reference) { create(:reference, tags: [tag.name])}
  Given(:meeting)   { create(:meeting, tags: [tag.name])}

  subject { tag }
 
  it  { should have_fields :name }
  it  { should respond_to(:slug) }
  it  { should respond_to(:references) }
  it  { should respond_to(:meetings) }

  it  { should allow_mass_assignment_of :name }
  it  { should_not allow_mass_assignment_of :slug }

  it  { should validate_presence_of(:name) }

  it  { tag.should be_valid }

  its(:to_s) { should == tag.name }

  describe "references" do 
    When { reference.save }

    Then { tag.references.count.should == 1 }
  end

  describe "meetings" do 
    When { meeting.save }

    Then { tag.meetings.count.should == 1 }
  end
end
