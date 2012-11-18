require 'spec_helper'
  
describe Tag do
  let(:tag)       { create(:tag) }
  let(:reference) { create(:reference, tags: [tag.name])}
  let(:meeting)   { create(:meeting, tags: [tag.name])}

  subject { tag }

  it { should respond_to(:name) }
  it { should respond_to(:slug) }
  it { should respond_to(:references) }
  it { should respond_to(:meetings) }

  it { should be_valid }

  its(:to_s) { should == tag.name }

  describe "references" do 
    before do
      reference.save
    end

    it { tag.references.count.should == 1 }
  end

  describe "meetings" do 
    before do
      meeting.save
    end

    it { tag.meetings.count.should == 1 }
  end
end
