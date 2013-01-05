require 'spec_helper'

describe Meeting do
  Given(:meeting) { build(:meeting, number: 1) }

  subject { meeting }

  it { should have_fields :title, :description, :datetime, :number, :location,
                          :number, :tags, :textbook_readings  }

  it { should belong_to :course }
  it { should belong_to :section }
  it { should have_and_belong_to_many :references }
  it { should embed_many :comments }

  it { should validate_presence_of :course }

  it { should be_valid }

  its(:to_s) { should == "Session #{ meeting.number } - #{ meeting.title.titleize }" }

  describe "only assign sections belonging to right course" do
    Given(:meeting)       { build(:meeting_with_section) }
    Given(:other_course)  { Course.new }
    
    When { meeting.course = other_course }

    Then { meeting.should_not be_valid }
    Then { meeting.should have(1).error_on(:section) }
  end

  describe "order meetings" do
    Given(:course)      { create(:defined_course) }
    Given(:meetings)      { course.meetings }
    Given(:meeting)       { meetings.find_by(title: "Introduction").reload }
    
    its(:number) { should == 1 }

    it "after updating datetime should change number" do
      meeting.datetime = Time.new(2130)
      meeting.save
      meeting.reload.number.should == 10
      meeting.datetime = Time.new(1999)
      meeting.save
      meeting.reload.number.should == 1
    end
  end

  describe "search" do
    When  { meeting.save }

    Then { Meeting.fulltext_search("bla").count.should == 1 }

    describe "three meetings" do
      Given(:two)   { create(:meeting, number: 2) }
      Given(:three) { create(:meeting, number: 3) }

      When do
        two.save
        three.save
      end

      Then { Meeting.fulltext_search("bla").count.should == 3 }
    end
  end

  describe "create_meeting" do
    Given(:course)  { create(:course) }
    Given(:meeting) do
      Meeting.create_meeting "New meeting", course do
      end
      course.meetings.first
    end

    Then  { expect(meeting.title).to eq  "New meeting" }
    And   { expect(meeting).to be_valid }
    And   { expect(meeting).to be_persisted }
  end
end
