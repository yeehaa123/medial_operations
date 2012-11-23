require 'spec_helper'

describe Meeting do
  let(:meeting) { build(:meeting, number: 1) }

  subject { meeting }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:course) }
  it { should respond_to(:datetime) }
  it { should respond_to(:section) }
  it { should respond_to(:references)}
  it { should respond_to(:comments) }

  it { should be_valid }
  it { should validate_presence_of(:course) }

  describe "only assign sections belonging to right course" do
    let(:meeting) { build(:meeting_with_section) }
    let(:other_course) { Course.new }
    
    before do 
      meeting.course = other_course
    end

    it { should_not be_valid }
    it { should have(1).error_on(:section) }
  end

  its(:to_s) { should == "#{ meeting.number } - #{ meeting.title.titleize }" }

  describe "order meetings" do
    let(:course)   { create(:defined_course) }
    let(:meetings) { course.meetings }
    let(:meeting)  { meetings.find_by(title: "Introduction").reload }
    
    its(:number) { should == 1 }

    it "after updating datetime should change number" do
      meeting.datetime = Time.new(2030)
      meeting.save
      meeting.reload.number.should == 10
      meeting.datetime = Time.now
      meeting.save
      meeting.reload.number.should == 1
    end
  end

  describe "search" do
    before do
      meeting.save
    end

    it { Meeting.fulltext_search("bla").count.should == 1 }

    describe "three meetings" do
      let(:two)   { create(:meeting, number: 2) }
      let(:three) { create(:meeting, number: 3) }

      before do
        two.save
        three.save
      end

      it { Meeting.fulltext_search("bla").count.should == 3 }
    end
  end
end
